import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({
    super.key,
    required this.isLoading,
    required this.hasFailed,
    required this.hasReachedEnd,
    required this.onRetry,
  });

  final bool isLoading;
  final bool hasFailed;
  final bool hasReachedEnd;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    final Widget child;
    if (isLoading) {
      child = const SizedBox.square(
        dimension: 28,
        child: CircularProgressIndicator(strokeWidth: 3),
      );
    } else if (hasFailed) {
      child = Column(
        children: [
          Text(l10n.loadMoreFailed, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ],
      );
    } else if (hasReachedEnd) {
      child = Text(
        l10n.endOfList,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    } else {
      child = const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Center(child: child),
    );
  }
}
