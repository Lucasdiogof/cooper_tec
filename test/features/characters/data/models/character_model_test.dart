import 'package:cooper_tec/features/characters/data/models/character_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures.dart';

void main() {
  group('CharacterModel.fromJson', () {
    test('maps the fields used by the app', () {
      final character = CharacterModel.fromJson(characterJson());

      expect(character.id, 1009368);
      expect(character.name, 'Iron Man');
      expect(character.hasDescription, isTrue);
      expect(character.comicsCount, 2593);
      expect(character.seriesCount, 1);
      expect(character.storiesCount, 3889);
      expect(character.eventsCount, 31);
      expect(character.series, ['Avengers (1998 - 2004)']);
      expect(character.modified, DateTime.utc(2016, 9, 28, 16, 8, 19));
    });

    test('builds https image urls for the list and the details screen', () {
      final character = CharacterModel.fromJson(characterJson());

      expect(
        character.thumbnailUrl,
        'https://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55/portrait_uncanny.jpg',
      );
      expect(
        character.imageUrl,
        'https://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55.jpg',
      );
    });

    test("treats Marvel's 'image not available' artwork as no image", () {
      final character = CharacterModel.fromJson(
        characterJson(
          imagePath:
              'http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available',
        ),
      );

      expect(character.thumbnailUrl, isNull);
      expect(character.imageUrl, isNull);
    });

    test('tolerates missing optional fields and placeholder dates', () {
      final character = CharacterModel.fromJson(const {
        'id': 7,
        'name': ' Blank ',
        'description': null,
        'modified': '-0001-11-30T00:00:00-0500',
      });

      expect(character.name, 'Blank');
      expect(character.description, isEmpty);
      expect(character.hasDescription, isFalse);
      expect(character.thumbnailUrl, isNull);
      expect(character.modified, isNull);
      expect(character.series, isEmpty);
      expect(character.comicsCount, 0);
    });
  });
}
