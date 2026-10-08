import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/marvel_attribution.dart';
import '../../../../core/widgets/status_view.dart';
import '../../../../l10n/failure_l10n.dart';
import '../../../../l10n/l10n.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../cubit/characters_cubit.dart';
import '../widgets/character_card.dart';
import '../widgets/character_card_skeleton.dart';
import '../widgets/pagination_footer.dart';
import 'character_details_page.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => getIt<CharactersCubit>()..load(),
        child: const CharactersPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const CharactersView();
}

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  static const _searchDebounce = Duration(milliseconds: 400);
  static const _loadMoreThreshold = 600.0;

  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreIfNeeded);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadMoreIfNeeded() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.extentAfter < _loadMoreThreshold) {
      context.read<CharactersCubit>().loadMore();
    }
  }

  void _onSearchChanged(String query) {
    setState(() {}); // Shows or hides the clear button.
    _debounce?.cancel();
    _debounce = Timer(_searchDebounce, () => _search(query));
  }

  void _search(String query) {
    _debounce?.cancel();
    context.read<CharactersCubit>().search(query);
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  void _clearSearch() {
    _searchController.clear();
    _search('');
    setState(() {});
  }

  void _signOut() {
    Navigator.of(context).pushAndRemoveUntil(LoginPage.route(), (_) => false);
  }

  void _onStateChanged(BuildContext context, CharactersState state) {
    if (state.status == CharactersStatus.failure &&
        state.characters.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.l10n.refreshFailed)));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadMoreIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: BlocConsumer<CharactersCubit, CharactersState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.characters.length != current.characters.length,
        listener: _onStateChanged,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: context.read<CharactersCubit>().refresh,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  title: Text(l10n.charactersTitle),
                  actions: [
                    IconButton(
                      tooltip: l10n.signOut,
                      icon: const Icon(Icons.logout),
                      onPressed: _signOut,
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(72),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: _SearchField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onSubmitted: _search,
                        onClear: _clearSearch,
                      ),
                    ),
                  ),
                ),
                ..._buildContent(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, CharactersState state) {
    final l10n = context.l10n;
    final cubit = context.read<CharactersCubit>();

    if (state.characters.isEmpty) {
      return switch (state.status) {
        CharactersStatus.initial ||
        CharactersStatus.loading => [_CharactersGrid.skeleton()],
        CharactersStatus.failure => [
          SliverFillRemaining(
            hasScrollBody: false,
            child: StatusView(
              icon: Icons.cloud_off_outlined,
              title: l10n.errorTitle,
              message: state.failure!.message(l10n),
              action: FilledButton.tonalIcon(
                onPressed: cubit.load,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ),
          ),
        ],
        CharactersStatus.success => [
          SliverFillRemaining(
            hasScrollBody: false,
            child: StatusView(
              icon: Icons.person_search_outlined,
              title: l10n.emptyTitle,
              message: state.query.isEmpty
                  ? l10n.emptyMessage
                  : l10n.emptySearchMessage(state.query),
            ),
          ),
        ],
      };
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        sliver: SliverToBoxAdapter(
          child: Text(
            l10n.heroesCount(state.total),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      _CharactersGrid(
        itemCount: state.characters.length,
        itemBuilder: (context, index) {
          final character = state.characters[index];
          return CharacterCard(
            character: character,
            onTap: () => Navigator.of(
              context,
            ).push(CharacterDetailsPage.route(character)),
          );
        },
      ),
      SliverToBoxAdapter(
        child: PaginationFooter(
          isLoading: state.isLoadingMore,
          hasFailed: state.loadMoreFailed,
          hasReachedEnd: state.hasReachedEnd,
          onRetry: cubit.retryLoadMore,
        ),
      ),
      const SliverToBoxAdapter(child: SafeArea(child: MarvelAttribution())),
    ];
  }
}

class _CharactersGrid extends StatelessWidget {
  const _CharactersGrid({required this.itemCount, required this.itemBuilder});

  factory _CharactersGrid.skeleton() => _CharactersGrid(
    itemCount: 8,
    itemBuilder: (_, _) => const CharacterCardSkeleton(),
  );

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: l10n.clearSearch,
                icon: const Icon(Icons.close),
                onPressed: onClear,
              ),
      ),
    );
  }
}
