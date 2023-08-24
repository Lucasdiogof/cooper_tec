part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.marvelEntity);

  final MarvelEntity marvelEntity;
}
