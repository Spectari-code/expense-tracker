import 'package:flutter/material.dart';

/// Custom expense tracker theme configuration
///
/// Provides consistent theming across the application with support for
/// both light and dark modes using Material 3 design principles.

/// Seed color for generating the application color palette
/// Bold blue for modern, confident design
const Color _seedColor = Color(0xFF3B82F6);

/// Light color scheme generated from the seed color
final ColorScheme kLightColorScheme = ColorScheme.fromSeed(
  seedColor: _seedColor,
  brightness: Brightness.light,
);

/// Dark color scheme generated from the seed color
final ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: _seedColor,
);

/// Light theme configuration for the expense tracker app
///
/// Features bold Material 3 design with enhanced styling for modern appearance.
/// Uses confident blue colors with proper elevation and typography hierarchy.
ThemeData lightTheme = ThemeData(
  colorScheme: kLightColorScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: kLightColorScheme.primary,
    foregroundColor: kLightColorScheme.onPrimary,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onPrimary,
    ),
  ),
  cardTheme: CardThemeData(
    color: kLightColorScheme.surface,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 6,
    shadowColor: kLightColorScheme.shadow.withValues(alpha: 0.15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kLightColorScheme.primary,
      foregroundColor: kLightColorScheme.onPrimary,
      elevation: 3,
      shadowColor: kLightColorScheme.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w700,
      color: kLightColorScheme.onSurface,
      fontSize: 32,
      height: 1.2,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: kLightColorScheme.onSurface,
      fontSize: 22,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kLightColorScheme.onSurfaceVariant,
      fontSize: 16,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      color: kLightColorScheme.onSurface,
      fontSize: 16,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: kLightColorScheme.onSurfaceVariant,
      fontSize: 14,
      height: 1.4,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kLightColorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kLightColorScheme.outline.withValues(alpha: 0.5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kLightColorScheme.outline.withValues(alpha: 0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kLightColorScheme.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
);

/// Dark theme configuration for the expense tracker app
///
/// Provides comfortable viewing experience in low-light conditions
/// with enhanced Material 3 styling and consistent visual hierarchy.
ThemeData darkTheme = ThemeData(
  colorScheme: kDarkColorScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkColorScheme.surface,
    foregroundColor: kDarkColorScheme.onSurface,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onSurface,
    ),
  ),
  cardTheme: CardThemeData(
    color: kDarkColorScheme.surface,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 6,
    shadowColor: kDarkColorScheme.shadow.withValues(alpha: 0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primary,
      foregroundColor: kDarkColorScheme.onPrimary,
      elevation: 3,
      shadowColor: kDarkColorScheme.primary.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w700,
      color: kDarkColorScheme.onSurface,
      fontSize: 32,
      height: 1.2,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      color: kDarkColorScheme.onSurface,
      fontSize: 22,
      height: 1.3,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      color: kDarkColorScheme.onSurfaceVariant,
      fontSize: 16,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      color: kDarkColorScheme.onSurface,
      fontSize: 16,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: kDarkColorScheme.onSurfaceVariant,
      fontSize: 14,
      height: 1.4,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kDarkColorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kDarkColorScheme.outline.withValues(alpha: 0.5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kDarkColorScheme.outline.withValues(alpha: 0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kDarkColorScheme.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
);