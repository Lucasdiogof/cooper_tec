import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/core/failure.dart';
import 'package:cooper_tec/features/domain/entities/marvel_entity.dart';
import 'package:cooper_tec/features/domain/usecases/get_characters_usecase.dart';
import 'package:cooper_tec/features/presentation/cubits/home_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCharactersUseCase extends Mock implements GetCharactersUseCase {}

void main() {
  late _MockGetCharactersUseCase getCharactersUseCase;

  setUp(() {
    getCharactersUseCase = _MockGetCharactersUseCase();
  });

  test('initial state is HomeInitial', () {
    final cubit = HomeCubit(getCharactersUseCase: getCharactersUseCase);
    expect(cubit.state, const HomeInitial());
  });

  blocTest<HomeCubit, HomeState>(
    'emits [HomeLoading, HomeSuccess] when getCharacters succeeds',
    build: () {
      const marvelEntity = MarvelEntity(characters: []);
      when(() => getCharactersUseCase())
          .thenAnswer((_) async => const Right(marvelEntity));
      return HomeCubit(getCharactersUseCase: getCharactersUseCase);
    },
    act: (cubit) => cubit.getCharacters(),
    expect: () => const [
      HomeLoading(),
      HomeSuccess(MarvelEntity(characters: [])),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [HomeLoading, HomeError] when getCharacters fails',
    build: () {
      when(() => getCharactersUseCase())
          .thenAnswer((_) async => const Left(Failure('network error')));
      return HomeCubit(getCharactersUseCase: getCharactersUseCase);
    },
    act: (cubit) => cubit.getCharacters(),
    expect: () => const [
      HomeLoading(),
      HomeError('network error'),
    ],
  );
}
