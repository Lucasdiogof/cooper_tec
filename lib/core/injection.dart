import 'package:cooper_tec/core/marvel_url_builder.dart';
import 'package:cooper_tec/features/data/datasources/marvel_remote_datasource.dart';
import 'package:cooper_tec/features/data/repositories/marvel_repository.dart';
import 'package:cooper_tec/features/domain/usecases/get_characters_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../features/domain/repositories/i_marvel_repository.dart';
import '../features/presentation/cubits/home_cubit.dart';

final instance = GetIt.instance;

void init() {
  instance.registerLazySingleton<http.Client>(http.Client.new);

  instance.registerLazySingleton(MarvelUrlBuilder.new);

  instance.registerLazySingleton<IMarvelRemoteDataSource>(
    () => MarvelRemoteDataSource(
      client: instance<http.Client>(),
      urlBuilder: instance<MarvelUrlBuilder>(),
    ),
  );

  instance.registerLazySingleton<IMarvelRepository>(
    () =>
        MarvelRepository(remoteDataSource: instance<IMarvelRemoteDataSource>()),
  );

  instance.registerLazySingleton(
    () => GetCharactersUseCase(
      repository: instance<IMarvelRepository>(),
    ),
  );

  instance.registerFactory(
    () => HomeCubit(getCharactersUseCase: instance<GetCharactersUseCase>()),
  );
}
