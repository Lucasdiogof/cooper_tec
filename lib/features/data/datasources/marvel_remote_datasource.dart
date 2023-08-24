import 'package:cooper_tec/core/key.dart';
import 'package:http/http.dart' as http;

abstract class IMarvelRemoteDataSource {
  Future<dynamic> getCharacters();
}

class MarvelRemoteDataSource implements IMarvelRemoteDataSource {
  final http.Client client = http.Client();

  @override
  Future<dynamic> getCharacters() async {
    return await client.get(
      Uri.parse(convertUrl()),
    );
  }
}
