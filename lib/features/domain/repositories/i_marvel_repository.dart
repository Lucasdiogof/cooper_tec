import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../entities/marvel_entity.dart';

abstract class IMarvelRepository {
  Future<Either<Failure, MarvelEntity>> getCharacters();
}
