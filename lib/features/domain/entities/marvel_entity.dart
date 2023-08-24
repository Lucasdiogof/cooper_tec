import 'package:cooper_tec/features/domain/entities/character_entity.dart';

class MarvelEntity {
  const MarvelEntity({
    required this.characters,
  });

  final List<CharacterEntity> characters;
}
