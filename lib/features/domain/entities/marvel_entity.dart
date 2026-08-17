import 'package:equatable/equatable.dart';

import 'character_entity.dart';

class MarvelEntity extends Equatable {
  const MarvelEntity({
    required this.characters,
  });

  final List<CharacterEntity> characters;

  @override
  List<Object?> get props => [characters];
}
