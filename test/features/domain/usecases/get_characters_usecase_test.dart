import 'package:cooper_tec/core/failure.dart';
import 'package:cooper_tec/features/domain/entities/marvel_entity.dart';
import 'package:cooper_tec/features/domain/repositories/i_marvel_repository.dart';
import 'package:cooper_tec/features/domain/usecases/get_characters_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMarvelRepository extends Mock implements IMarvelRepository {}

void main() {
  late _MockMarvelRepository repository;
  late GetCharactersUseCase useCase;

  setUp(() {
    repository = _MockMarvelRepository();
    useCase = GetCharactersUseCase(repository: repository);
  });

  test('delegates to IMarvelRepository.getCharacters', () async {
    const marvelEntity = MarvelEntity(characters: []);
    when(() => repository.getCharacters())
        .thenAnswer((_) async => const Right(marvelEntity));

    final result = await useCase();

    expect(result, const Right<Failure, MarvelEntity>(marvelEntity));
    verify(() => repository.getCharacters()).called(1);
  });

  test('propagates a Failure from the repository', () async {
    const failure = Failure('boom');
    when(() => repository.getCharacters())
        .thenAnswer((_) async => const Left(failure));

    final result = await useCase();

    expect(result, const Left<Failure, MarvelEntity>(failure));
  });
}
