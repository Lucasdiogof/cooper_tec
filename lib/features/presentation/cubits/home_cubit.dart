import 'package:cooper_tec/features/domain/entities/marvel_entity.dart';
import 'package:cooper_tec/features/domain/usecases/get_characters_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required GetCharactersUseCase getCharactersUseCase,
  })  : _getCharactersUseCase = getCharactersUseCase,
        super(HomeInitial());

  final GetCharactersUseCase _getCharactersUseCase;

  Future<void> getCharacters() async {
    emit(HomeLoading());
    final result = await _getCharactersUseCase();
    result.fold(
      (_) => emit(HomeError()),
      (marvel) {
        emit(HomeSuccess(marvel));
      },
    );
  }
}
