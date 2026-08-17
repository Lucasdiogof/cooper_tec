import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:cooper_tec/features/domain/entities/character_series_entity.dart';
import 'package:cooper_tec/features/presentation/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const character = CharacterEntity(
    id: 42,
    name: 'Iron Man',
    description: '',
    modified: '',
    series: [CharacterSeriesEntity(name: 'Avengers (1963 - 1996)')],
  );

  testWidgets('shows the character name', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CharacterWidget(character: character)),
      ),
    );

    expect(find.text('Iron Man'), findsOneWidget);
  });

  testWidgets('navigates to the detail page on tap', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: CharacterWidget(character: character)),
      ),
    );

    await tester.tap(find.text('Iron Man'));
    await tester.pumpAndSettle();

    expect(find.text('ID: 42'), findsOneWidget);
    expect(find.text('Avengers (1963 - 1996)'), findsOneWidget);
  });
}
