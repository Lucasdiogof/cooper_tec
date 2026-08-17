import 'package:cooper_tec/features/data/models/marvel_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarvelModel.fromMap', () {
    test('parses the character list from the Marvel API envelope', () {
      final map = {
        'data': {
          'results': [
            {
              'id': 1,
              'name': 'Iron Man',
              'description': '',
              'modified': '',
              'series': {'items': <Map<String, dynamic>>[]},
            },
            {
              'id': 2,
              'name': 'Thor',
              'description': '',
              'modified': '',
              'series': {'items': <Map<String, dynamic>>[]},
            },
          ],
        },
      };

      final model = MarvelModel.fromMap(map);

      expect(model.characters, hasLength(2));
      expect(model.characters.map((c) => c.name), ['Iron Man', 'Thor']);
    });
  });
}
