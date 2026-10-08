import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/core/di/injection.dart';
import 'package:cooper_tec/features/auth/presentation/pages/login_page.dart';
import 'package:cooper_tec/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:cooper_tec/features/characters/presentation/pages/characters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

class _MockCharactersCubit extends MockCubit<CharactersState>
    implements CharactersCubit {}

void main() {
  setUp(() {
    final cubit = _MockCharactersCubit();
    // A settled state, so pumpAndSettle doesn't wait on the loading skeleton.
    when(
      () => cubit.state,
    ).thenReturn(const CharactersState(status: CharactersStatus.success));
    when(cubit.load).thenAnswer((_) async {});
    getIt.registerFactory<CharactersCubit>(() => cubit);
  });

  tearDown(getIt.reset);

  Future<void> fillAndSubmit(
    WidgetTester tester, {
    required String email,
    required String password,
  }) async {
    await tester.enterText(find.byKey(const Key('login_email')), email);
    await tester.enterText(find.byKey(const Key('login_password')), password);
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows validation errors for invalid input', (tester) async {
    await tester.pumpApp(const LoginPage());

    await fillAndSubmit(tester, email: 'peter', password: '123');

    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(
      find.text('Password must have at least 6 characters'),
      findsOneWidget,
    );
    expect(find.byType(CharactersPage), findsNothing);
  });

  testWidgets('opens the heroes list with valid credentials', (tester) async {
    await tester.pumpApp(const LoginPage());

    await fillAndSubmit(
      tester,
      email: 'peter@dailybugle.com',
      password: 'with-great-power',
    );

    expect(find.byType(CharactersPage), findsOneWidget);
    expect(find.byType(LoginPage), findsNothing);
  });

  testWidgets('toggles password visibility', (tester) async {
    await tester.pumpApp(const LoginPage());

    TextField passwordField() => tester.widget<TextField>(
      find.descendant(
        of: find.byKey(const Key('login_password')),
        matching: find.byType(TextField),
      ),
    );

    expect(passwordField().obscureText, isTrue);

    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();

    expect(passwordField().obscureText, isFalse);
  });
}
