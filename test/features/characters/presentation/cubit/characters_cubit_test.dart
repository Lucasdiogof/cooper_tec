import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:cooper_tec/core/error/failure.dart';
import 'package:cooper_tec/core/result/result.dart';
import 'package:cooper_tec/features/characters/domain/entities/paginated_characters.dart';
import 'package:cooper_tec/features/characters/domain/usecases/get_characters.dart';
import 'package:cooper_tec/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fixtures.dart';

class _MockGetCharacters extends Mock implements GetCharacters {}

void main() {
  late _MockGetCharacters getCharacters;

  final ironMan = buildCharacter(id: 1, name: 'Iron Man');
  final thor = buildCharacter(id: 2, name: 'Thor');
  final firstPage = PaginatedCharacters(
    characters: [ironMan],
    offset: 0,
    total: 2,
  );
  final lastPage = PaginatedCharacters(characters: [thor], offset: 1, total: 2);

  setUp(() => getCharacters = _MockGetCharacters());

  void stub(
    Result<PaginatedCharacters> result, {
    int offset = 0,
    String query = '',
  }) {
    when(
      () => getCharacters(offset: offset, query: query),
    ).thenAnswer((_) async => result);
  }

  CharactersCubit build() => CharactersCubit(getCharacters);

  test('starts in the initial state', () {
    expect(build().state, const CharactersState());
  });

  group('load', () {
    blocTest<CharactersCubit, CharactersState>(
      'emits loading then the first page',
      setUp: () => stub(Ok(firstPage)),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const CharactersState(status: CharactersStatus.loading),
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan],
          total: 2,
        ),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'marks the end when everything fits in one page',
      setUp: () => stub(
        Ok(PaginatedCharacters(characters: [ironMan], offset: 0, total: 1)),
      ),
      build: build,
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => [
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan],
          total: 1,
          hasReachedEnd: true,
        ),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'emits the failure when the request fails',
      setUp: () => stub(const Err(NetworkFailure())),
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => const [
        CharactersState(status: CharactersStatus.loading),
        CharactersState(
          status: CharactersStatus.failure,
          failure: NetworkFailure(),
        ),
      ],
    );
  });

  group('loadMore', () {
    blocTest<CharactersCubit, CharactersState>(
      'appends the next page and stops at the total',
      setUp: () => stub(Ok(lastPage), offset: 1),
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan],
        total: 2,
      ),
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan],
          total: 2,
          isLoadingMore: true,
        ),
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan, thor],
          total: 2,
          hasReachedEnd: true,
        ),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'keeps the current list when the next page fails',
      setUp: () => stub(const Err(NetworkFailure()), offset: 1),
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan],
        total: 2,
      ),
      act: (cubit) => cubit.loadMore(),
      skip: 1,
      expect: () => [
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan],
          total: 2,
          loadMoreFailed: true,
        ),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'does nothing after the last page',
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan, thor],
        total: 2,
        hasReachedEnd: true,
      ),
      act: (cubit) => cubit.loadMore(),
      expect: () => const <CharactersState>[],
      verify: (_) => verifyNever(
        () => getCharacters(
          offset: any(named: 'offset'),
          query: any(named: 'query'),
        ),
      ),
    );

    blocTest<CharactersCubit, CharactersState>(
      'retryLoadMore tries the failed page again',
      setUp: () => stub(Ok(lastPage), offset: 1),
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan],
        total: 2,
        loadMoreFailed: true,
      ),
      act: (cubit) => cubit.retryLoadMore(),
      skip: 1,
      expect: () => [
        CharactersState(
          status: CharactersStatus.success,
          characters: [ironMan, thor],
          total: 2,
          hasReachedEnd: true,
        ),
      ],
    );
  });

  group('search', () {
    blocTest<CharactersCubit, CharactersState>(
      'clears the list and loads the results for the trimmed query',
      setUp: () => stub(Ok(lastPage.copyWithOffsetZero()), query: 'Thor'),
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan],
        total: 2,
      ),
      act: (cubit) => cubit.search('  Thor '),
      expect: () => [
        const CharactersState(status: CharactersStatus.loading, query: 'Thor'),
        CharactersState(
          status: CharactersStatus.success,
          query: 'Thor',
          characters: [thor],
          total: 2,
        ),
      ],
    );

    blocTest<CharactersCubit, CharactersState>(
      'ignores a query that is already showing',
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        query: 'Thor',
        characters: [thor],
        total: 1,
      ),
      act: (cubit) => cubit.search('Thor '),
      expect: () => const <CharactersState>[],
    );

    test('drops responses from searches that were replaced', () async {
      final slowSearch = Completer<Result<PaginatedCharacters>>();
      when(
        () => getCharacters(query: 'I'),
      ).thenAnswer((_) => slowSearch.future);
      stub(Ok(lastPage.copyWithOffsetZero()), query: 'Th');

      final cubit = build();
      final first = cubit.search('I');
      await cubit.search('Th');
      slowSearch.complete(Ok(firstPage));
      await first;

      expect(cubit.state.query, 'Th');
      expect(cubit.state.characters, [thor]);
      await cubit.close();
    });
  });

  group('refresh', () {
    blocTest<CharactersCubit, CharactersState>(
      'keeps the current list visible while reloading',
      setUp: () => stub(const Err(NetworkFailure())),
      build: build,
      seed: () => CharactersState(
        status: CharactersStatus.success,
        characters: [ironMan],
        total: 2,
      ),
      act: (cubit) => cubit.refresh(),
      expect: () => [
        CharactersState(
          status: CharactersStatus.loading,
          characters: [ironMan],
          total: 2,
        ),
        CharactersState(
          status: CharactersStatus.failure,
          characters: [ironMan],
          total: 2,
          failure: const NetworkFailure(),
        ),
      ],
    );
  });
}

extension on PaginatedCharacters {
  PaginatedCharacters copyWithOffsetZero() =>
      PaginatedCharacters(characters: characters, offset: 0, total: total);
}
