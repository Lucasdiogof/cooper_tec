import 'package:cooper_tec/core/result/result.dart';
import 'package:cooper_tec/features/characters/domain/entities/paginated_characters.dart';
import 'package:cooper_tec/features/characters/domain/repositories/characters_repository.dart';
import 'package:cooper_tec/features/characters/domain/usecases/get_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  late _MockCharactersRepository repository;
  late GetCharacters getCharacters;

  const page = PaginatedCharacters(characters: [], offset: 0, total: 0);

  setUp(() {
    repository = _MockCharactersRepository();
    getCharacters = GetCharacters(repository);
    when(
      () => repository.getCharacters(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
        nameStartsWith: any(named: 'nameStartsWith'),
      ),
    ).thenAnswer((_) async => const Ok(page));
  });

  test('asks for the first page with the default page size', () async {
    expect(await getCharacters(), const Ok(page));

    verify(
      () => repository.getCharacters(offset: 0, limit: GetCharacters.pageSize),
    ).called(1);
  });

  test('trims the query before searching', () async {
    await getCharacters(offset: 30, query: '  spider ');

    verify(
      () => repository.getCharacters(
        offset: 30,
        limit: GetCharacters.pageSize,
        nameStartsWith: 'spider',
      ),
    ).called(1);
  });

  test('does not filter by name when the query is blank', () async {
    await getCharacters(query: '   ');

    verify(
      () => repository.getCharacters(offset: 0, limit: GetCharacters.pageSize),
    ).called(1);
  });
}
