import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/core/error/failure.dart';
import 'package:cooper_tec/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:cooper_tec/features/characters/presentation/pages/character_details_page.dart';
import 'package:cooper_tec/features/characters/presentation/pages/characters_page.dart';
import 'package:cooper_tec/features/characters/presentation/widgets/character_card.dart';
import 'package:cooper_tec/features/characters/presentation/widgets/character_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/pump_app.dart';

class _MockCharactersCubit extends MockCubit<CharactersState>
    implements CharactersCubit {}

void main() {
  late _MockCharactersCubit cubit;

  setUp(() {
    cubit = _MockCharactersCubit();
    when(cubit.load).thenAnswer((_) async {});
    when(cubit.loadMore).thenAnswer((_) async {});
    when(cubit.retryLoadMore).thenAnswer((_) async {});
    when(cubit.refresh).thenAnswer((_) async {});
    when(() => cubit.search(any())).thenAnswer((_) async {});
  });

  Future<void> pumpPage(WidgetTester tester, CharactersState state) {
    when(() => cubit.state).thenReturn(state);
    return tester.pumpApp(
      BlocProvider<CharactersCubit>.value(
        value: cubit,
        child: const CharactersView(),
      ),
    );
  }

  final heroes = CharactersState(
    status: CharactersStatus.success,
    characters: [
      buildCharacter(id: 1, name: 'Iron Man'),
      buildCharacter(id: 2, name: 'Thor'),
    ],
    total: 1564,
  );

  testWidgets('shows skeleton cards while the first page loads', (
    tester,
  ) async {
    await pumpPage(
      tester,
      const CharactersState(status: CharactersStatus.loading),
    );

    expect(find.byType(CharacterCardSkeleton), findsWidgets);
    expect(find.byType(CharacterCard), findsNothing);
  });

  testWidgets('shows the heroes and the total count', (tester) async {
    await pumpPage(tester, heroes);

    expect(find.text('1,564 heroes'), findsOneWidget);
    expect(find.widgetWithText(CharacterCard, 'Iron Man'), findsOneWidget);
    expect(find.widgetWithText(CharacterCard, 'Thor'), findsOneWidget);
  });

  testWidgets('opens the details page when a hero is tapped', (tester) async {
    await pumpPage(tester, heroes);

    await tester.tap(find.widgetWithText(CharacterCard, 'Thor'));
    await tester.pumpAndSettle();

    expect(find.byType(CharacterDetailsPage), findsOneWidget);
  });

  testWidgets('shows the error with a retry button', (tester) async {
    await pumpPage(
      tester,
      const CharactersState(
        status: CharactersStatus.failure,
        failure: NetworkFailure(),
      ),
    );

    expect(
      find.text('No internet connection. Check your network and try again.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Try again'));
    verify(cubit.load).called(1);
  });

  testWidgets('mentions the query when a search has no results', (
    tester,
  ) async {
    await pumpPage(
      tester,
      const CharactersState(status: CharactersStatus.success, query: 'Xyz'),
    );

    expect(find.text('No heroes found'), findsOneWidget);
    expect(find.textContaining('"Xyz"'), findsOneWidget);
  });

  testWidgets('searches after the user stops typing', (tester) async {
    await pumpPage(tester, heroes);

    await tester.enterText(find.byType(TextField), 'Spi');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'Spider');
    verifyNever(() => cubit.search(any()));

    await tester.pump(const Duration(milliseconds: 400));
    verify(() => cubit.search('Spider')).called(1);
  });

  testWidgets('offers a retry when the next page fails', (tester) async {
    await pumpPage(tester, heroes.copyWith(loadMoreFailed: true));

    await tester.scrollUntilVisible(
      find.text('Try again'),
      300,
      scrollable: find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    );
    await tester.tap(find.text('Try again'));

    verify(cubit.retryLoadMore).called(1);
  });
}
