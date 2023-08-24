import '../../domain/entities/character_series_entity.dart';

class CharacterSeriesModel extends CharacterSeriesEntity {
  const CharacterSeriesModel({
    required super.name,
  });

  factory CharacterSeriesModel.fromMap(Map<String, dynamic> map) {
    return CharacterSeriesModel(
      name: map['name'],
    );
  }
}
