import 'package:cooper_tec/app/app.dart';
import 'package:cooper_tec/app/missing_config_page.dart';
import 'package:cooper_tec/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts on the login page when the keys are set', (tester) async {
    await tester.pumpWidget(const CooperTecApp(isConfigured: true));

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('explains how to add the keys when they are missing', (
    tester,
  ) async {
    await tester.pumpWidget(const CooperTecApp(isConfigured: false));

    expect(find.byType(MissingConfigPage), findsOneWidget);
    expect(find.text(MissingConfigPage.command), findsOneWidget);
  });

  testWidgets('follows the device language', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('pt', 'BR')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const CooperTecApp(isConfigured: true));

    expect(find.text('Entrar'), findsOneWidget);
  });
}
