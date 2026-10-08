import '../../../../core/result/result.dart';
import '../entities/paginated_characters.dart';
import '../repositories/characters_repository.dart';

class GetCharacters {
  const GetCharacters(this._repository);

  static const pageSize = 30;

  final CharactersRepository _repository;

  Future<Result<PaginatedCharacters>> call({
    int offset = 0,
    int limit = pageSize,
    String query = '',
  }) {
    final name = query.trim();
    return _repository.getCharacters(
      offset: offset,
      limit: limit,
      nameStartsWith: name.isEmpty ? null : name,
    );
  }
}
