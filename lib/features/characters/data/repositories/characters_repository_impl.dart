import 'dart:async';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/paginated_characters.dart';
import '../../domain/repositories/characters_repository.dart';
import '../datasources/characters_remote_data_source.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  const CharactersRepositoryImpl(this._remoteDataSource);

  final CharactersRemoteDataSource _remoteDataSource;

  @override
  Future<Result<PaginatedCharacters>> getCharacters({
    required int offset,
    required int limit,
    String? nameStartsWith,
  }) async {
    try {
      final page = await _remoteDataSource.getCharacters(
        offset: offset,
        limit: limit,
        nameStartsWith: nameStartsWith,
      );
      return Ok(page);
    } on ServerException catch (e) {
      return Err(_failureForStatus(e.statusCode));
    } on http.ClientException {
      return const Err(NetworkFailure());
    } on TimeoutException {
      return const Err(NetworkFailure());
    } on FormatException {
      return const Err(ParsingFailure());
    } on TypeError {
      // A field with an unexpected type in the payload.
      return const Err(ParsingFailure());
    } catch (_) {
      return const Err(UnexpectedFailure());
    }
  }

  // 409 is what Marvel returns for a missing key, hash or timestamp.
  Failure _failureForStatus(int statusCode) => switch (statusCode) {
    401 || 403 || 409 => const UnauthorizedFailure(),
    429 => const RateLimitFailure(),
    _ => ServerFailure(statusCode),
  };
}
