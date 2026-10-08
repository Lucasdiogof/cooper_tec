import 'package:flutter/material.dart';

import '../core/widgets/status_view.dart';
import '../l10n/l10n.dart';

/// Shown instead of the app when it was started without the Marvel keys,
/// so whoever cloned the repo sees what to do instead of a red error screen.
class MissingConfigPage extends StatelessWidget {
  const MissingConfigPage({super.key});

  static const command = 'flutter run --dart-define-from-file=env.json';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: StatusView(
          icon: Icons.key_off_outlined,
          title: context.l10n.missingConfigTitle,
          message: context.l10n.missingConfigMessage,
          action: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SelectableText(
              command,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
