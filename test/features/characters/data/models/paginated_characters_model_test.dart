import 'package:cooper_tec/features/characters/data/models/paginated_characters_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  test('reads offset, total and results from the response envelope', () {
    final page = PaginatedCharactersModel.fromJson(
      charactersResponseJson(
        results: [characterJson(id: 1), characterJson(id: 2)],
        offset: 30,
        total: 100,
      ),
    );

    expect(page.offset, 30);
    expect(page.total, 100);
    expect(page.characters.map((c) => c.id), [1, 2]);
    expect(page.hasMore, isTrue);
  });

  test('has no more pages once offset + count reaches the total', () {
    final page = PaginatedCharactersModel.fromJson(
      charactersResponseJson(
        results: [characterJson()],
        offset: 99,
        total: 100,
      ),
    );

    expect(page.hasMore, isFalse);
  });
}
