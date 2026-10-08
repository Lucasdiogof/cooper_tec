import 'dart:convert';

import 'package:crypto/crypto.dart';

class MarvelUrlBuilder {
  MarvelUrlBuilder({
    required String publicKey,
    required String privateKey,
    DateTime Function()? clock,
  }) : _publicKey = publicKey,
       _privateKey = privateKey,
       _clock = clock ?? DateTime.now;

  static const _baseUrl = 'https://gateway.marvel.com/v1/public';

  final String _publicKey;
  final String _privateKey;
  final DateTime Function() _clock;

  Uri characters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  }) {
    return Uri.parse('$_baseUrl/characters').replace(
      queryParameters: {
        'orderBy': 'name',
        'offset': '$offset',
        'limit': '$limit',
        if (nameStartsWith != null && nameStartsWith.isNotEmpty)
          'nameStartsWith': nameStartsWith,
        ..._authParameters(),
      },
    );
  }

  Map<String, String> _authParameters() {
    final timestamp = _clock().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode('$timestamp$_privateKey$_publicKey'));
    return {'ts': timestamp, 'apikey': _publicKey, 'hash': '$hash'};
  }
}
