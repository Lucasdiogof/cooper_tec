import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

/// Marvel's API terms ask apps to credit them wherever their data is shown.
class MarvelAttribution extends StatelessWidget {
  const MarvelAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Text(
        context.l10n.marvelAttribution(DateTime.now().year),
        textAlign: TextAlign.center,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
