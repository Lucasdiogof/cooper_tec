import 'dart:convert';

import 'package:cooper_tec/core/network/marvel_url_builder.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.fromMillisecondsSinceEpoch(1700000000000);
  final builder = MarvelUrlBuilder(
    publicKey: 'public',
    privateKey: 'private',
    clock: () => now,
  );

  group('MarvelUrlBuilder.characters', () {
    test('points to the characters endpoint with paging and ordering', () {
      final uri = builder.characters(offset: 60, limit: 30);

      expect(
        uri.toString(),
        startsWith('https://gateway.marvel.com/v1/public/characters?'),
      );
      expect(uri.queryParameters, containsPair('offset', '60'));
      expect(uri.queryParameters, containsPair('limit', '30'));
      expect(uri.queryParameters, containsPair('orderBy', 'name'));
      expect(uri.queryParameters, isNot(contains('nameStartsWith')));
    });

    test(
      'signs the request with ts, apikey and md5(ts + private + public)',
      () {
        final uri = builder.characters(offset: 0, limit: 30);
        final expectedHash = md5.convert(
          utf8.encode('1700000000000privatepublic'),
        );

        expect(uri.queryParameters, containsPair('ts', '1700000000000'));
        expect(uri.queryParameters, containsPair('apikey', 'public'));
        expect(uri.queryParameters, containsPair('hash', '$expectedHash'));
      },
    );

    test('adds nameStartsWith only when a name is given', () {
      expect(
        builder
            .characters(offset: 0, limit: 30, nameStartsWith: 'Spider')
            .queryParameters,
        containsPair('nameStartsWith', 'Spider'),
      );
      expect(
        builder
            .characters(offset: 0, limit: 30, nameStartsWith: '')
            .queryParameters,
        isNot(contains('nameStartsWith')),
      );
    });
  });
}
