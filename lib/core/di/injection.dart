import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/characters/data/datasources/characters_remote_data_source.dart';
import '../../features/characters/data/repositories/characters_repository_impl.dart';
import '../../features/characters/domain/repositories/characters_repository.dart';
import '../../features/characters/domain/usecases/get_characters.dart';
import '../../features/characters/presentation/cubit/characters_cubit.dart';
import '../config/env_config.dart';
import '../network/marvel_url_builder.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton<http.Client>(http.Client.new)
    ..registerLazySingleton(
      () => MarvelUrlBuilder(
        publicKey: EnvConfig.marvelPublicKey,
        privateKey: EnvConfig.marvelPrivateKey,
      ),
    )
    ..registerLazySingleton<CharactersRemoteDataSource>(
      () => MarvelCharactersRemoteDataSource(
        client: getIt(),
        urlBuilder: getIt(),
      ),
    )
    ..registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(getIt()),
    )
    ..registerLazySingleton(() => GetCharacters(getIt()))
    ..registerFactory(() => CharactersCubit(getIt()));
}
