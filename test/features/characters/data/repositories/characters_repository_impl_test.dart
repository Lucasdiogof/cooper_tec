import 'dart:async';

import 'package:cooper_tec/core/error/exceptions.dart';
import 'package:cooper_tec/core/error/failure.dart';
import 'package:cooper_tec/core/result/result.dart';
import 'package:cooper_tec/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:cooper_tec/features/characters/data/models/paginated_characters_model.dart';
import 'package:cooper_tec/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:cooper_tec/features/characters/domain/entities/paginated_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures.dart';

class _MockRemoteDataSource extends Mock
    implements CharactersRemoteDataSource {}

void main() {
  late _MockRemoteDataSource remoteDataSource;
  late CharactersRepositoryImpl repository;

  setUp(() {
    remoteDataSource = _MockRemoteDataSource();
    repository = CharactersRepositoryImpl(remoteDataSource);
  });

  void stubDataSource(Future<PaginatedCharactersModel> Function() answer) {
    when(
      () => remoteDataSource.getCharacters(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        nameStartsWith: any(named: 'nameStartsWith'),
      ),
    ).thenAnswer((_) => answer());
  }

  Future<Result<PaginatedCharacters>> getCharacters() =>
      repository.getCharacters(offset: 0, limit: 30, nameStartsWith: 'Thor');

  test('returns the page from the data source', () async {
    final page = PaginatedCharactersModel.fromJson(charactersResponseJson());
    stubDataSource(() async => page);

    expect(await getCharacters(), Ok<PaginatedCharacters>(page));
    verify(
      () => remoteDataSource.getCharacters(
        offset: 0,
        limit: 30,
        nameStartsWith: 'Thor',
      ),
    ).called(1);
  });

  final cases = <String, (Object, Failure)>{
    '401': (const ServerException(401), const UnauthorizedFailure()),
    '409': (const ServerException(409), const UnauthorizedFailure()),
    '429': (const ServerException(429), const RateLimitFailure()),
    '500': (const ServerException(500), const ServerFailure(500)),
    'no connection': (http.ClientException('offline'), const NetworkFailure()),
    'timeout': (TimeoutException('slow'), const NetworkFailure()),
    'invalid json': (const FormatException('bad'), const ParsingFailure()),
    'anything else': (StateError('boom'), const UnexpectedFailure()),
  };

  for (final MapEntry(key: name, value: (error, failure)) in cases.entries) {
    test('maps $name to $failure', () async {
      stubDataSource(() async => throw error);

      expect(await getCharacters(), Err<PaginatedCharacters>(failure));
    });
  }
}
