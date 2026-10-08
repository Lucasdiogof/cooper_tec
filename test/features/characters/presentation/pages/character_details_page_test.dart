import 'package:cooper_tec/features/characters/presentation/pages/character_details_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the description, stats and series', (tester) async {
    final character = buildCharacter(
      name: 'Iron Man',
      description: 'Genius. Billionaire. Philanthropist.',
      seriesCount: 3,
      series: ['Avengers (1998 - 2004)'],
      modified: DateTime(2016, 9, 28),
    );

    await tester.pumpApp(CharacterDetailsPage(character: character));

    expect(find.text('Iron Man'), findsOneWidget);
    expect(find.text('Genius. Billionaire. Philanthropist.'), findsOneWidget);
    expect(find.text('Updated Sep 28, 2016'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Comics'), 200);
    expect(find.text('12'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('+2 more series'), 200);
    expect(find.text('Avengers (1998 - 2004)'), findsOneWidget);
  });

  testWidgets('explains when there is no description or series', (
    tester,
  ) async {
    await tester.pumpApp(CharacterDetailsPage(character: buildCharacter()));

    expect(
      find.text("Marvel hasn't published a description for this hero yet."),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text("This hero hasn't appeared in any series yet."),
      200,
    );
  });
}
