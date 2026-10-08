import '../../../../core/result/result.dart';
import '../entities/paginated_characters.dart';

abstract interface class CharactersRepository {
  Future<Result<PaginatedCharacters>> getCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  });
}
