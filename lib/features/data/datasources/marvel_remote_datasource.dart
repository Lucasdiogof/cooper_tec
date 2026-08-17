import 'package:cooper_tec/core/marvel_url_builder.dart';
import 'package:http/http.dart' as http;

abstract class IMarvelRemoteDataSource {
  Future<http.Response> getCharacters();
}

class MarvelRemoteDataSource implements IMarvelRemoteDataSource {
  const MarvelRemoteDataSource({
    required http.Client client,
    required MarvelUrlBuilder urlBuilder,
  })  : _client = client,
        _urlBuilder = urlBuilder;

  final http.Client _client;
  final MarvelUrlBuilder _urlBuilder;

  @override
  Future<http.Response> getCharacters() {
    return _client.get(_urlBuilder.buildCharactersUrl());
  }
}
