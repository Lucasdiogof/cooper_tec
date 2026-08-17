import 'package:cooper_tec/features/data/models/character_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterModel.fromMap', () {
    test('parses a character with its series', () {
      final map = {
        'id': 1009368,
        'name': 'Iron Man',
        'description': 'Genius. Billionaire. Playboy. Philanthropist.',
        'modified': '2020-04-04T19:04:04-0400',
        'series': {
          'items': [
            {'name': 'Avengers (1963 - 1996)'},
            {'name': 'Iron Man (1968 - 1996)'},
          ],
        },
      };

      final model = CharacterModel.fromMap(map);

      expect(model.id, 1009368);
      expect(model.name, 'Iron Man');
      expect(
          model.description, 'Genius. Billionaire. Playboy. Philanthropist.');
      expect(model.modified, '2020-04-04T19:04:04-0400');
      expect(model.series, hasLength(2));
      expect(model.series.first.name, 'Avengers (1963 - 1996)');
    });

    test('parses a character with an empty series list', () {
      final map = {
        'id': 1,
        'name': 'Nameless Hero',
        'description': '',
        'modified': '',
        'series': {'items': <Map<String, dynamic>>[]},
      };

      final model = CharacterModel.fromMap(map);

      expect(model.series, isEmpty);
    });
  });
}
