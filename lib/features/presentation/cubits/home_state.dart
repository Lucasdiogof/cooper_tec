part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.marvelEntity);

  final MarvelEntity marvelEntity;

  @override
  List<Object?> get props => [marvelEntity];
}
