import 'dart:convert';

import 'package:crypto/crypto.dart';

class Helper {
  static String publicApiKey = "1d76f2680f3d6789462ebf56a978a25e";
  static String privateApiKey = "55bfedd429dae6eb51995744db37fd8906afb545";
}

var url = "http://gateway.marvel.com/v1/public/characters";
var timeStamp = DateTime.now();
late String hash;

String convertUrl() {
  _gerarHash();
  return "$url?apikey=${Helper.publicApiKey}&hash=$hash&ts=${timeStamp.toIso8601String()}";
}

void _gerarHash() {
  hash = generateMd5(
      timeStamp.toIso8601String() + Helper.privateApiKey + Helper.publicApiKey);
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
