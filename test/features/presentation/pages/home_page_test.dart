import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:cooper_tec/features/domain/entities/marvel_entity.dart';
import 'package:cooper_tec/features/presentation/cubits/home_cubit.dart';
import 'package:cooper_tec/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late _MockHomeCubit cubit;

  setUp(() {
    cubit = _MockHomeCubit();
    when(() => cubit.getCharacters()).thenAnswer((_) async {});
  });

  void stubState(HomeState state) {
    whenListen(cubit, Stream<HomeState>.value(state), initialState: state);
  }

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<HomeCubit>.value(
        value: cubit,
        child: const HomePage(),
      ),
    );
  }

  testWidgets('shows a loading indicator for HomeLoading', (tester) async {
    stubState(const HomeLoading());

    await tester.pumpWidget(buildSubject());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows the character list for HomeSuccess', (tester) async {
    const character = CharacterEntity(
      id: 1,
      name: 'Iron Man',
      description: '',
      modified: '',
      series: [],
    );
    stubState(const HomeSuccess(MarvelEntity(characters: [character])));

    await tester.pumpWidget(buildSubject());

    expect(find.text('Iron Man'), findsOneWidget);
  });

  testWidgets('shows an empty message when there are no characters',
      (tester) async {
    stubState(const HomeSuccess(MarvelEntity(characters: [])));

    await tester.pumpWidget(buildSubject());

    expect(find.text('No heroes found.'), findsOneWidget);
  });

  testWidgets('shows the error message and retries on tap', (tester) async {
    stubState(const HomeError('network error'));

    await tester.pumpWidget(buildSubject());

    expect(find.text('network error'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pump();

    verify(() => cubit.getCharacters()).called(greaterThanOrEqualTo(1));
  });
}
