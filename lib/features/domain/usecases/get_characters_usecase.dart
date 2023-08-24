import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../entities/marvel_entity.dart';
import '../repositories/i_marvel_repository.dart';

class GetCharactersUseCase {
  const GetCharactersUseCase({
    required IMarvelRepository repository,
  }) : _repository = repository;

  final IMarvelRepository _repository;

  Future<Either<Failure, MarvelEntity>> call() => _repository.getCharacters();
}
