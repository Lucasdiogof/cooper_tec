import 'dart:convert';

import 'package:cooper_tec/core/env_config.dart';
import 'package:cooper_tec/core/marvel_url_builder.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarvelUrlBuilder', () {
    const builder = MarvelUrlBuilder();

    test('builds a characters URL with apikey, ts and a matching hash', () {
      final uri = builder.buildCharactersUrl();

      expect(uri.scheme, 'https');
      expect(uri.host, 'gateway.marvel.com');
      expect(uri.path, '/v1/public/characters');

      final ts = uri.queryParameters['ts'];
      final hash = uri.queryParameters['hash'];
      expect(ts, isNotNull);
      expect(uri.queryParameters['apikey'], EnvConfig.marvelPublicApiKey);

      final expectedHash = md5
          .convert(utf8.encode(
              '$ts${EnvConfig.marvelPrivateApiKey}${EnvConfig.marvelPublicApiKey}'))
          .toString();
      expect(hash, expectedHash);
    });

    test('uses a fresh timestamp on every call', () async {
      final first = builder.buildCharactersUrl();
      await Future<void>.delayed(const Duration(milliseconds: 2));
      final second = builder.buildCharactersUrl();

      expect(first.queryParameters['ts'], isNot(second.queryParameters['ts']));
    });
  });
}
