import 'package:cooper_tec/features/characters/presentation/widgets/character_image.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows initials when there is no image', (tester) async {
    await tester.pumpApp(
      const CharacterImage(name: 'Spider-Man (Peter Parker)', url: null),
    );

    expect(find.text('SM'), findsOneWidget);
  });

  testWidgets('falls back to the initials when the image fails to load', (
    tester,
  ) async {
    // Network images always fail inside widget tests.
    await tester.pumpApp(
      const CharacterImage(
        name: 'Black Widow',
        url: 'https://example.com/a.jpg',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('BW'), findsWidgets);
  });
}
