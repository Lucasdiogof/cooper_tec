part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.marvelEntity);

  final MarvelEntity marvelEntity;
}
