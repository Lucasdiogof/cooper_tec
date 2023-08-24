import '../../domain/entities/marvel_entity.dart';
import 'character_model.dart';

class MarvelModel extends MarvelEntity {
  const MarvelModel({
    required super.characters,
  });

  factory MarvelModel.fromMap(Map<String, dynamic> map) {
    return MarvelModel(
      characters: (map['data']['results'] as List)
          .map((character) => CharacterModel.fromMap(character))
          .toList(),
    );
  }
}
