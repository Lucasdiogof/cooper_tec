import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';
import '../../domain/entities/marvel_entity.dart';
import '../../domain/repositories/i_marvel_repository.dart';
import '../datasources/marvel_remote_datasource.dart';
import '../models/marvel_model.dart';

class MarvelRepository implements IMarvelRepository {
  const MarvelRepository({
    required IMarvelRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final IMarvelRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, MarvelEntity>> getCharacters() async {
    try {
      final response = await _remoteDataSource.getCharacters();
      if (response.statusCode == 200) {
        final characters = MarvelModel.fromMap(jsonDecode(response.body));
        return Right(characters);
      }
      return Left(
        Failure('Failed to load heroes (status ${response.statusCode}).'),
      );
    } on SocketException {
      return const Left(
        Failure('No internet connection. Please check your network.'),
      );
    } on FormatException {
      return const Left(
        Failure('Received an unexpected response from the server.'),
      );
    } catch (_) {
      return const Left(
        Failure('Something went wrong while loading the heroes.'),
      );
    }
  }
}
