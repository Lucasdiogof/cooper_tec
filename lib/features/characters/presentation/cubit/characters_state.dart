part of 'characters_cubit.dart';

enum CharactersStatus { initial, loading, success, failure }

class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const [],
    this.total = 0,
    this.query = '',
    this.hasReachedEnd = false,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
    this.failure,
  });

  final CharactersStatus status;
  final List<Character> characters;
  final int total;
  final String query;
  final bool hasReachedEnd;
  final bool isLoadingMore;
  final bool loadMoreFailed;
  final Failure? failure;

  bool get canLoadMore =>
      status == CharactersStatus.success &&
      !hasReachedEnd &&
      !isLoadingMore &&
      !loadMoreFailed;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    int? total,
    String? query,
    bool? hasReachedEnd,
    bool? isLoadingMore,
    bool? loadMoreFailed,
    Failure? Function()? failure,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      total: total ?? this.total,
      query: query ?? this.query,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    characters,
    total,
    query,
    hasReachedEnd,
    isLoadingMore,
    loadMoreFailed,
    failure,
  ];
}
