import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

class MarvelEntity extends Equatable {
  const MarvelEntity({
    required this.characters,
  });

  final List<CharacterEntity> characters;

  @override
  List<Object?> get props => [
        characters,
      ];
}
