import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:cooper_tec/features/domain/entities/character_series_entity.dart';
import 'package:cooper_tec/features/presentation/widgets/detailed_character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the character id and its series', (tester) async {
    const character = CharacterEntity(
      id: 7,
      name: 'Thor',
      description: '',
      modified: '',
      series: [
        CharacterSeriesEntity(name: 'Thor (1966 - 1996)'),
        CharacterSeriesEntity(name: 'Avengers (1963 - 1996)'),
      ],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DetailedCharacterWidget(character: character),
        ),
      ),
    );

    expect(find.text('ID: 7'), findsOneWidget);
    expect(find.text('Thor (1966 - 1996)'), findsOneWidget);
    expect(find.text('Avengers (1963 - 1996)'), findsOneWidget);
  });

  testWidgets('shows a fallback message when there are no series',
      (tester) async {
    const character = CharacterEntity(
      id: 1,
      name: 'Nameless Hero',
      description: '',
      modified: '',
      series: [],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DetailedCharacterWidget(character: character),
        ),
      ),
    );

    expect(find.text('No series found for this hero.'), findsOneWidget);
  });
}
