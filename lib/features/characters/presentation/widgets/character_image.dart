import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({
    super.key,
    required this.name,
    required this.url,
    this.highResUrl,
  });

  final String name;
  final String? url;
  final String? highResUrl;

  static Object heroTag(int characterId) => 'character-image-$characterId';

  @override
  Widget build(BuildContext context) {
    final placeholder = _Placeholder(name: name);
    if (url == null) return placeholder;

    return Stack(
      fit: StackFit.expand,
      children: [
        _FadeInImage(url: url!, placeholder: placeholder),
        if (highResUrl != null)
          _FadeInImage(url: highResUrl!, placeholder: const SizedBox.shrink()),
      ],
    );
  }
}

class _FadeInImage extends StatelessWidget {
  const _FadeInImage({required this.url, required this.placeholder});

  final String url;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return Stack(
          fit: StackFit.expand,
          children: [
            placeholder,
            AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            ),
          ],
        );
      },
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.name});

  final String name;

  String get _initials {
    final words = name
        .replaceAll(RegExp(r'\(.*?\)'), '')
        .split(RegExp(r'[\s-]+'))
        .where((word) => word.isNotEmpty);
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }

  double get _hue =>
      name.codeUnits.fold<int>(0, (sum, unit) => sum + unit) % 360.0;

  @override
  Widget build(BuildContext context) {
    final base = HSLColor.fromAHSL(1, _hue, 0.45, 0.35);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [base.toColor(), base.withLightness(0.15).toColor()],
        ),
      ),
      child: Center(
        child: Text(
          _initials,
          style: const TextStyle(
            fontFamily: AppTheme.displayFont,
            fontSize: 56,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
