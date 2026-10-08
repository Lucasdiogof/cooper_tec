import 'package:flutter/material.dart';

abstract final class AppColors {
  static const marvelRed = Color(0xFFEC1D24);
  static const ink = Color(0xFF151515);
}

abstract final class AppTheme {
  static const displayFont = 'BebasNeue';

  static final light = _build(Brightness.light);
  static final dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.marvelRed,
      brightness: brightness,
    ).copyWith(primary: AppColors.marvelRed, onPrimary: Colors.white);

    final base = ThemeData(colorScheme: colorScheme, useMaterial3: true);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return base.copyWith(
      textTheme: base.textTheme.copyWith(
        displayLarge: _display(base.textTheme.displayLarge),
        displayMedium: _display(base.textTheme.displayMedium),
        displaySmall: _display(base.textTheme.displaySmall),
        headlineLarge: _display(base.textTheme.headlineLarge),
        headlineMedium: _display(base.textTheme.headlineMedium),
        headlineSmall: _display(base.textTheme.headlineSmall),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        // The base text theme has no font sizes yet (Theme.of merges them in
        // later), so the size has to be explicit here.
        titleTextStyle: TextStyle(
          fontFamily: displayFont,
          fontSize: 32,
          letterSpacing: 1.2,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: shape,
          textStyle: base.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: const StadiumBorder(),
        side: BorderSide.none,
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static TextStyle? _display(TextStyle? style) =>
      style?.copyWith(fontFamily: displayFont, letterSpacing: 1.2);
}
