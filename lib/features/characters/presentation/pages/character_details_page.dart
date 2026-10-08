import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/marvel_attribution.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/character.dart';
import '../widgets/character_image.dart';
import '../widgets/stat_tile.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.character});

  final Character character;

  static Route<void> route(Character character) {
    return MaterialPageRoute(
      builder: (_) => CharacterDetailsPage(character: character),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final hiddenSeries = character.seriesCount - character.series.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 420,
            backgroundColor: AppColors.ink,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTheme.displayFont,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: CharacterImage.heroTag(character.id),
                    child: CharacterImage(
                      name: character.name,
                      url: character.thumbnailUrl,
                      highResUrl: character.imageUrl,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.25, 0.6, 1],
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            sliver: SliverList.list(
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.tag, size: 18),
                      label: Text(l10n.detailsId(character.id)),
                    ),
                    if (character.modified case final modified?)
                      Chip(
                        avatar: const Icon(Icons.update, size: 18),
                        label: Text(l10n.detailsLastUpdated(modified)),
                      ),
                  ],
                ),
                _SectionTitle(l10n.detailsAbout),
                Text(
                  character.hasDescription
                      ? character.description
                      : l10n.detailsNoDescription,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                    color: character.hasDescription
                        ? null
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                _SectionTitle(l10n.detailsAppearances),
                _StatsRow(character: character),
                _SectionTitle(l10n.detailsSeries),
                if (character.series.isEmpty)
                  Text(
                    l10n.detailsNoSeries,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  )
                else
                  ...character.series.map(_SeriesTile.new),
                if (hiddenSeries > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l10n.detailsMoreSeries(hiddenSeries),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SafeArea(child: MarvelAttribution())),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stats = [
      (Icons.menu_book_outlined, character.comicsCount, l10n.statComics),
      (Icons.live_tv_outlined, character.seriesCount, l10n.statSeries),
      (Icons.auto_stories_outlined, character.storiesCount, l10n.statStories),
      (Icons.bolt_outlined, character.eventsCount, l10n.statEvents),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 340 ? 2 : 4;
        const spacing = 8.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final (icon, value, label) in stats)
              SizedBox(
                width: width,
                child: StatTile(icon: icon, value: value, label: label),
              ),
          ],
        );
      },
    );
  }
}

class _SeriesTile extends StatelessWidget {
  const _SeriesTile(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: theme.colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(Icons.movie_outlined, color: theme.colorScheme.primary),
          title: Text(title),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Text(text, style: Theme.of(context).textTheme.headlineSmall),
    );
  }
}
