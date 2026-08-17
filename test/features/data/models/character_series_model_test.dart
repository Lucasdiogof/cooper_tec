import 'package:cooper_tec/features/data/models/character_series_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterSeriesModel.fromMap', () {
    test('parses the series name', () {
      final model = CharacterSeriesModel.fromMap(const {'name': 'Civil War'});

      expect(model.name, 'Civil War');
    });
  });
}
