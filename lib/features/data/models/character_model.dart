import 'package:cooper_tec/features/data/models/character_series_model.dart';

import '../../domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.description,
    required super.modified,
    required super.name,
    required super.series,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'],
      description: map['description'],
      modified: map['modified'],
      name: map['name'],
      series: (map['series']['items'] as List)
          .map((series) => CharacterSeriesModel.fromMap(series))
          .toList(),
    );
  }
}
