import 'dart:convert';
import 'dart:io';

import 'package:cooper_tec/core/failure.dart';
import 'package:cooper_tec/features/data/datasources/marvel_remote_datasource.dart';
import 'package:cooper_tec/features/data/repositories/marvel_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class _MockRemoteDataSource extends Mock implements IMarvelRemoteDataSource {}

void main() {
  late _MockRemoteDataSource remoteDataSource;
  late MarvelRepository repository;

  setUp(() {
    remoteDataSource = _MockRemoteDataSource();
    repository = MarvelRepository(remoteDataSource: remoteDataSource);
  });

  const successBody = {
    'data': {
      'results': [
        {
          'id': 1,
          'name': 'Iron Man',
          'description': '',
          'modified': '',
          'series': {'items': <Map<String, dynamic>>[]},
        },
      ],
    },
  };

  group('getCharacters', () {
    test('returns a MarvelEntity when the response is 200', () async {
      when(() => remoteDataSource.getCharacters()).thenAnswer(
        (_) async => http.Response(jsonEncode(successBody), 200),
      );

      final result = await repository.getCharacters();

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('expected a Right value'),
        (marvel) => expect(marvel.characters, hasLength(1)),
      );
    });

    test('returns a Failure with the status code when the response fails',
        () async {
      when(() => remoteDataSource.getCharacters()).thenAnswer(
        (_) async => http.Response('Internal Server Error', 500),
      );

      final result = await repository.getCharacters();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure.message, contains('500')),
        (_) => fail('expected a Left value'),
      );
    });

    test('returns a Failure when there is no internet connection', () async {
      when(() => remoteDataSource.getCharacters())
          .thenThrow(const SocketException('no internet'));

      final result = await repository.getCharacters();

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<Failure>()),
        (_) => fail('expected a Left value'),
      );
    });

    test('returns a Failure when the response body cannot be decoded',
        () async {
      when(() => remoteDataSource.getCharacters()).thenAnswer(
        (_) async => http.Response('not-json', 200),
      );

      final result = await repository.getCharacters();

      expect(result.isLeft(), isTrue);
    });
  });
}
