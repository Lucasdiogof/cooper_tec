import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'env_config.dart';

class MarvelUrlBuilder {
  const MarvelUrlBuilder();

  static const String _charactersEndpoint =
      'https://gateway.marvel.com/v1/public/characters';

  Uri buildCharactersUrl() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return Uri.parse(_charactersEndpoint).replace(
      queryParameters: {
        'apikey': EnvConfig.marvelPublicApiKey,
        'ts': timestamp,
        'hash': _generateHash(timestamp),
      },
    );
  }

  String _generateHash(String timestamp) {
    final rawHash =
        '$timestamp${EnvConfig.marvelPrivateApiKey}${EnvConfig.marvelPublicApiKey}';
    return md5.convert(utf8.encode(rawHash)).toString();
  }
}
