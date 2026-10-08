import 'package:flutter/material.dart';

/// Pulsing grey card shown while the first page is loading.
class CharacterCardSkeleton extends StatefulWidget {
  const CharacterCardSkeleton({super.key});

  @override
  State<CharacterCardSkeleton> createState() => _CharacterCardSkeletonState();
}

class _CharacterCardSkeletonState extends State<CharacterCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  late final _opacity = Tween<double>(
    begin: 0.4,
    end: 1,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}
