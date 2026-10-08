import 'dart:convert';

import 'package:cooper_tec/core/error/exceptions.dart';
import 'package:cooper_tec/core/network/marvel_url_builder.dart';
import 'package:cooper_tec/features/characters/data/datasources/characters_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  final urlBuilder = MarvelUrlBuilder(
    publicKey: 'public',
    privateKey: 'private',
  );

  MarvelCharactersRemoteDataSource dataSource(MockClientHandler handler) {
    return MarvelCharactersRemoteDataSource(
      client: MockClient(handler),
      urlBuilder: urlBuilder,
    );
  }

  test('requests the right page and parses the response', () async {
    late Uri requested;
    final source = dataSource((request) async {
      requested = request.url;
      return http.Response(jsonEncode(charactersResponseJson()), 200);
    });

    final page = await source.getCharacters(
      offset: 30,
      limit: 30,
      nameStartsWith: 'Iron',
    );

    expect(requested.path, '/v1/public/characters');
    expect(requested.queryParameters, containsPair('offset', '30'));
    expect(requested.queryParameters, containsPair('nameStartsWith', 'Iron'));
    expect(page.characters.single.name, 'Iron Man');
  });

  test('decodes the body as utf8 even without a charset header', () async {
    final source = dataSource((_) async {
      final body = jsonEncode(
        charactersResponseJson(results: [characterJson(name: 'Rōnin')]),
      );
      return http.Response.bytes(utf8.encode(body), 200);
    });

    final page = await source.getCharacters(offset: 0, limit: 30);

    expect(page.characters.single.name, 'Rōnin');
  });

  test('throws a ServerException with the status code on errors', () {
    final source = dataSource((_) async => http.Response('{"code": 401}', 401));

    expect(
      source.getCharacters(offset: 0, limit: 30),
      throwsA(
        isA<ServerException>().having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
  });

  test('throws a FormatException when the body is not a JSON object', () {
    final source = dataSource((_) async => http.Response('[]', 200));

    expect(source.getCharacters(offset: 0, limit: 30), throwsFormatException);
  });
}
