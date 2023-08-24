import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../domain/entities/marvel_entity.dart';
import '../../domain/repositories/i_marvel_repository.dart';
import '../../domain/entities/character_entity.dart';
import '../datasources/marvel_remote_datasource.dart';
import '../models/character_model.dart';
import 'package:http/http.dart' as http;

import '../models/marvel_model.dart';

class MarvelRepository implements IMarvelRepository {
  const MarvelRepository({
    required IMarvelRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final IMarvelRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, MarvelEntity>> getCharacters() async {
    final http.Response response = await _remoteDataSource.getCharacters();
    if (response.statusCode == 200) {
      final characters = MarvelModel.fromMap(jsonDecode(response.body));
      return Right(characters);
    }
    return Left(Failure());
  }
}
