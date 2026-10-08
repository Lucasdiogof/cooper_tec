import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this._getCharacters) : super(const CharactersState());

  final GetCharacters _getCharacters;

  // Used to drop responses from searches that were already replaced.
  int _generation = 0;

  Future<void> load() => _loadFirstPage(query: state.query);

  Future<void> search(String query) {
    final trimmed = query.trim();
    if (trimmed == state.query && state.status == CharactersStatus.success) {
      return Future.value();
    }
    return _loadFirstPage(query: trimmed);
  }

  Future<void> refresh() =>
      _loadFirstPage(query: state.query, keepCharacters: true);

  Future<void> loadMore() async {
    if (!state.canLoadMore) return;
    await _loadNextPage();
  }

  Future<void> retryLoadMore() async {
    if (!state.loadMoreFailed) return;
    await _loadNextPage();
  }

  Future<void> _loadFirstPage({
    required String query,
    bool keepCharacters = false,
  }) async {
    final generation = ++_generation;
    emit(
      CharactersState(
        status: CharactersStatus.loading,
        query: query,
        characters: keepCharacters ? state.characters : const [],
        total: keepCharacters ? state.total : 0,
      ),
    );

    final result = await _getCharacters(query: query);
    if (isClosed || generation != _generation) return;

    switch (result) {
      case Ok(value: final page):
        emit(
          state.copyWith(
            status: CharactersStatus.success,
            characters: page.characters,
            total: page.total,
            hasReachedEnd: !page.hasMore,
          ),
        );
      case Err(:final failure):
        emit(
          state.copyWith(
            status: CharactersStatus.failure,
            failure: () => failure,
          ),
        );
    }
  }

  Future<void> _loadNextPage() async {
    final generation = _generation;
    emit(state.copyWith(isLoadingMore: true, loadMoreFailed: false));

    final result = await _getCharacters(
      offset: state.characters.length,
      query: state.query,
    );
    if (isClosed || generation != _generation) return;

    switch (result) {
      case Ok(value: final page):
        emit(
          state.copyWith(
            characters: [...state.characters, ...page.characters],
            total: page.total,
            hasReachedEnd: !page.hasMore || page.characters.isEmpty,
            isLoadingMore: false,
          ),
        );
      case Err():
        emit(state.copyWith(isLoadingMore: false, loadMoreFailed: true));
    }
  }
}
