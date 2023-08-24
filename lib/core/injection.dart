import 'package:cooper_tec/features/data/datasources/marvel_remote_datasource.dart';
import 'package:cooper_tec/features/data/repositories/marvel_repository.dart';
import 'package:cooper_tec/features/domain/usecases/get_characters_usecase.dart';
import 'package:get_it/get_it.dart';
import '../features/domain/repositories/i_marvel_repository.dart';
import '../features/presentation/cubits/home_cubit.dart';

final instance = GetIt.instance;

void init() {
  instance.registerLazySingleton<IMarvelRepository>(() =>
      MarvelRepository(remoteDataSource: instance<IMarvelRemoteDataSource>()));

  instance.registerLazySingleton(
    () => GetCharactersUseCase(
      repository: instance<IMarvelRepository>(),
    ),
  );

  instance.registerLazySingleton<IMarvelRemoteDataSource>(
    () => MarvelRemoteDataSource(),
  );

  instance.registerFactory(
    () => HomeCubit(getCharactersUseCase: instance<GetCharactersUseCase>()),
  );
}
