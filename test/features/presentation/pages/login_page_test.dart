import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/features/presentation/cubits/home_cubit.dart';
import 'package:cooper_tec/features/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late _MockHomeCubit cubit;

  setUp(() async {
    await GetIt.instance.reset();
    cubit = _MockHomeCubit();
    when(() => cubit.getCharacters()).thenAnswer((_) async {});
    whenListen(
      cubit,
      Stream<HomeState>.value(const HomeInitial()),
      initialState: const HomeInitial(),
    );
    GetIt.instance.registerFactory<HomeCubit>(() => cubit);
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  Widget buildSubject() => const MaterialApp(home: LoginPage());

  testWidgets('shows validation errors for empty fields', (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
    expect(find.text('Password must be at least 6 characters long'),
        findsOneWidget);
  });

  testWidgets('shows an error for an invalid email format', (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Enter a valid email'), findsOneWidget);
  });

  testWidgets('toggles password visibility', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('navigates to the home page with valid credentials',
      (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.enterText(
      find.byType(TextFormField).first,
      'hero@marvel.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'secret123');
    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Marvel Heroes'), findsOneWidget);
  });
}
