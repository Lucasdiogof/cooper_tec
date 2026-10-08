import '../../domain/entities/paginated_characters.dart';
import 'character_model.dart';

class PaginatedCharactersModel extends PaginatedCharacters {
  const PaginatedCharactersModel({
    required super.characters,
    required super.offset,
    required super.total,
  });

  /// Parses the whole response envelope returned by `/v1/public/characters`.
  factory PaginatedCharactersModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;

    return PaginatedCharactersModel(
      offset: data['offset'] as int? ?? 0,
      total: data['total'] as int? ?? results.length,
      characters: [
        for (final result in results)
          CharacterModel.fromJson(result as Map<String, dynamic>),
      ],
    );
  }
}
