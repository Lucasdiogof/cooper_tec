import 'package:cooper_tec/features/domain/entities/character_series_entity.dart';
import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.series,
  });

  final int id;
  final String name;
  final String description;
  final String modified;
  final List<CharacterSeriesEntity> series;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        modified,
        series,
      ];
}
