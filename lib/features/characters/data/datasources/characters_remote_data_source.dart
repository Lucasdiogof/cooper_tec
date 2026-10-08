import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/marvel_url_builder.dart';
import '../models/paginated_characters_model.dart';

abstract interface class CharactersRemoteDataSource {
  Future<PaginatedCharactersModel> getCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  });
}

class MarvelCharactersRemoteDataSource implements CharactersRemoteDataSource {
  const MarvelCharactersRemoteDataSource({
    required http.Client client,
    required MarvelUrlBuilder urlBuilder,
  }) : _client = client,
       _urlBuilder = urlBuilder;

  static const _timeout = Duration(seconds: 15);

  final http.Client _client;
  final MarvelUrlBuilder _urlBuilder;

  @override
  Future<PaginatedCharactersModel> getCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  }) async {
    final url = _urlBuilder.characters(
      offset: offset,
      limit: limit,
      nameStartsWith: nameStartsWith,
    );
    final response = await _client.get(url).timeout(_timeout);

    if (response.statusCode != 200) {
      throw ServerException(response.statusCode);
    }

    // response.body falls back to latin1 when there's no charset header.
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Expected a JSON object');
    }
    return PaginatedCharactersModel.fromJson(json);
  }
}
