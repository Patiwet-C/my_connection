import 'package:flutter/material.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/utils/local_storage.dart';

class AppColour {
  AppColour._();

  // ===== LIGHT THEME COLOURS =====
  // Primary brand colours - Light blue
  static const Color _lightPrimary = Color(0xFF3B82F6);
  static const Color _lightOnPrimary = Color(0xFFFFFFFF);
  static const Color _lightPrimaryContainer = Color(0xFFEFF6FF);
  static const Color _lightOnPrimaryContainer = Color(0xFF1E40AF);

  // Secondary colours - Subtle grey
  static const Color _lightSecondary = Color(0xFF6B7280);
  static const Color _lightOnSecondary = Color(0xFFFFFFFF);
  static const Color _lightSecondaryContainer = Color(0xFFF3F4F6);
  static const Color _lightOnSecondaryContainer = Color(0xFF374151);

  // Tertiary colours - Muted green
  static const Color _lightTertiary = Color(0xFF10B981);
  static const Color _lightOnTertiary = Color(0xFFFFFFFF);
  static const Color _lightTertiaryContainer = Color(0xFFECFDF5);
  static const Color _lightOnTertiaryContainer = Color(0xFF065F46);

  // Surface and background colours - White background, grey text
  static const Color _lightSurface = Color(0xFFF1F5F9);
  static const Color _lightOnSurface = Color(0xFF374151);
  static const Color _lightSurfaceVariant = Color(
    0xFFF1F5F9,
  ); // Slightly darker than background
  static const Color _lightOnSurfaceVariant = Color(
    0xFF475569,
  ); // Darker grey for better contrast
  static const Color _lightBackground = Color(
    0xFFF8FAFC,
  ); // Very light blue-grey background
  static const Color _lightOnBackground = Color(0xFF374151); // Grey text

  // Error colours - Subtle red
  static const Color _lightError = Color(0xFFEF4444);
  static const Color _lightOnError = Color(0xFFFFFFFF);
  static const Color _lightErrorContainer = Color(0xFFFEF2F2);
  static const Color _lightOnErrorContainer = Color(0xFF991B1B);

  // Success colours - Subtle green
  static const Color _lightSuccess = Color(0xFF10B981);
  static const Color _lightOnSuccess = Color(0xFFFFFFFF);
  static const Color _lightSuccessContainer = Color(0xFFECFDF5);
  static const Color _lightOnSuccessContainer = Color(0xFF065F46);

  // Warning colours - Subtle amber
  static const Color _lightWarning = Color(0xFFF59E0B);
  static const Color _lightOnWarning = Color(0xFFFFFFFF);
  static const Color _lightWarningContainer = Color(0xFFFFFBEB);
  static const Color _lightOnWarningContainer = Color(0xFF92400E);

  // Outline and divider colours - Subtle grey
  static const Color _lightOutline = Color(0xFFE5E7EB);
  static const Color _lightOutlineVariant = Color(0xFFD1D5DB);

  // ===== DARK THEME COLOURS =====
  // Primary brand colours - Light blue (same as light)
  static const Color _darkPrimary = Color(0xFF3B82F6); // Same light blue
  static const Color _darkOnPrimary = Color(0xFFFFFFFF);
  static const Color _darkPrimaryContainer = Color(0xFF1E40AF);
  static const Color _darkOnPrimaryContainer = Color(0xFFEFF6FF);

  // Secondary colours - Subtle grey
  static const Color _darkSecondary = Color(
    0xFF9CA3AF,
  ); // Lighter grey for dark mode
  static const Color _darkOnSecondary = Color(0xFF1F2937);
  static const Color _darkSecondaryContainer = Color(0xFF374151);
  static const Color _darkOnSecondaryContainer = Color(0xFFF3F4F6);

  // Tertiary colours - Muted green
  static const Color _darkTertiary = Color(0xFF34D399);
  static const Color _darkOnTertiary = Color(0xFF064E3B);
  static const Color _darkTertiaryContainer = Color(0xFF065F46);
  static const Color _darkOnTertiaryContainer = Color(0xFFECFDF5);

  // Surface and background colours - Dark grey background, white text
  static const Color _darkSurface = Color(0xFF1A1A1A);
  static const Color _darkOnSurface = Color(0xFFF8FAFC);
  static const Color _darkSurfaceVariant = Color(0xFF475569);
  static const Color _darkOnSurfaceVariant = Color(0xFFE2E8F0);
  static const Color _darkBackground = Color(0xFF374151);
  static const Color _darkOnBackground = Color(0xFFF8FAFC);

  // Error colours - Subtle red
  static const Color _darkError = Color(0xFFF87171);
  static const Color _darkOnError = Color(0xFF7F1D1D);
  static const Color _darkErrorContainer = Color(0xFF991B1B);
  static const Color _darkOnErrorContainer = Color(0xFFFEF2F2);

  // Success colours - Subtle green
  static const Color _darkSuccess = Color(0xFF34D399);
  static const Color _darkOnSuccess = Color(0xFF064E3B);
  static const Color _darkSuccessContainer = Color(0xFF065F46);
  static const Color _darkOnSuccessContainer = Color(0xFFECFDF5);

  // Warning colours - Subtle amber
  static const Color _darkWarning = Color(0xFFFBBF24);
  static const Color _darkOnWarning = Color(0xFF78350F);
  static const Color _darkWarningContainer = Color(0xFF92400E);
  static const Color _darkOnWarningContainer = Color(0xFFFFFBEB);

  // Outline and divider colours - Subtle grey
  static const Color _darkOutline = Color(0xFF4B5563);
  static const Color _darkOutlineVariant = Color(0xFF6B7280);

  // ===== THEME-AWARE GETTERS =====
  // Primary colours
  static Color get primary => _getColour(_lightPrimary, _darkPrimary);
  static Color get onPrimary => _getColour(_lightOnPrimary, _darkOnPrimary);
  static Color get primaryContainer =>
      _getColour(_lightPrimaryContainer, _darkPrimaryContainer);
  static Color get onPrimaryContainer =>
      _getColour(_lightOnPrimaryContainer, _darkOnPrimaryContainer);

  // Secondary colours
  static Color get secondary => _getColour(_lightSecondary, _darkSecondary);
  static Color get onSecondary =>
      _getColour(_lightOnSecondary, _darkOnSecondary);
  static Color get secondaryContainer =>
      _getColour(_lightSecondaryContainer, _darkSecondaryContainer);
  static Color get onSecondaryContainer =>
      _getColour(_lightOnSecondaryContainer, _darkOnSecondaryContainer);

  // Tertiary colours
  static Color get tertiary => _getColour(_lightTertiary, _darkTertiary);
  static Color get onTertiary => _getColour(_lightOnTertiary, _darkOnTertiary);
  static Color get tertiaryContainer =>
      _getColour(_lightTertiaryContainer, _darkTertiaryContainer);
  static Color get onTertiaryContainer =>
      _getColour(_lightOnTertiaryContainer, _darkOnTertiaryContainer);

  // Surface and background colours
  static Color get surface => _getColour(_lightSurface, _darkSurface);
  static Color get onSurface => _getColour(_lightOnSurface, _darkOnSurface);
  static Color get surfaceVariant =>
      _getColour(_lightSurfaceVariant, _darkSurfaceVariant);
  static Color get onSurfaceVariant =>
      _getColour(_lightOnSurfaceVariant, _darkOnSurfaceVariant);
  static Color get background => _getColour(_lightBackground, _darkBackground);
  static Color get onBackground =>
      _getColour(_lightOnBackground, _darkOnBackground);

  // Error colours
  static Color get error => _getColour(_lightError, _darkError);
  static Color get onError => _getColour(_lightOnError, _darkOnError);
  static Color get errorContainer =>
      _getColour(_lightErrorContainer, _darkErrorContainer);
  static Color get onErrorContainer =>
      _getColour(_lightOnErrorContainer, _darkOnErrorContainer);

  // Success colours
  static Color get success => _getColour(_lightSuccess, _darkSuccess);
  static Color get onSuccess => _getColour(_lightOnSuccess, _darkOnSuccess);
  static Color get successContainer =>
      _getColour(_lightSuccessContainer, _darkSuccessContainer);
  static Color get onSuccessContainer =>
      _getColour(_lightOnSuccessContainer, _darkOnSuccessContainer);

  // Warning colours
  static Color get warning => _getColour(_lightWarning, _darkWarning);
  static Color get onWarning => _getColour(_lightOnWarning, _darkOnWarning);
  static Color get warningContainer =>
      _getColour(_lightWarningContainer, _darkWarningContainer);
  static Color get onWarningContainer =>
      _getColour(_lightOnWarningContainer, _darkOnWarningContainer);

  // Outline colours
  static Color get outline => _getColour(_lightOutline, _darkOutline);
  static Color get outlineVariant =>
      _getColour(_lightOutlineVariant, _darkOutlineVariant);

  // ===== COMMON COLOURS (NOT THEME-DEPENDENT) =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Grey scale
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Black scale
  static const Color black50 = Color(0xFFF8F9FA);
  static const Color black100 = Color(0xFFE9ECEF);
  static const Color black200 = Color(0xFFDEE2E6);
  static const Color black300 = Color(0xFFCED4DA);
  static const Color black400 = Color(0xFFADB5BD);
  static const Color black500 = Color(0xFF6C757D);
  static const Color black600 = Color(0xFF495057);
  static const Color black700 = Color(0xFF343A40);
  static const Color black800 = Color(0xFF212529);
  static const Color black900 = Color(0xFF000000);

  // ===== SHADOW COLOURS =====
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);
  static const Color shadowColour = Color(0x1F000000);

  // ===== LEGACY SUPPORT (for backward compatibility) =====
  // These maintain the old naming convention for existing code
  static Color get primaryText => onSurface;
  static Color get secondaryText => onSurfaceVariant;
  static Color get primaryButton => primary;
  static Color get secondaryButton => secondaryContainer;

  // ===== UTILITY METHODS =====
  static Color _getColour(Color lightColour, Color darkColour) {
    final storage = getIt<LocalStorage>();
    final isDarkMode =
        storage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false;
    return isDarkMode ? darkColour : lightColour;
  }

  static ColorScheme getColorScheme(bool isDarkMode) {
    if (isDarkMode) {
      return const ColorScheme.dark(
        primary: _darkPrimary,
        onPrimary: _darkOnPrimary,
        primaryContainer: _darkPrimaryContainer,
        onPrimaryContainer: _darkOnPrimaryContainer,
        secondary: _darkSecondary,
        onSecondary: _darkOnSecondary,
        secondaryContainer: _darkSecondaryContainer,
        onSecondaryContainer: _darkOnSecondaryContainer,
        tertiary: _darkTertiary,
        onTertiary: _darkOnTertiary,
        tertiaryContainer: _darkTertiaryContainer,
        onTertiaryContainer: _darkOnTertiaryContainer,
        surface: _darkSurface,
        onSurface: _darkOnSurface,
        surfaceContainerHighest: _darkSurfaceVariant,
        onSurfaceVariant: _darkOnSurfaceVariant,
        error: _darkError,
        onError: _darkOnError,
        errorContainer: _darkErrorContainer,
        onErrorContainer: _darkOnErrorContainer,
        outline: _darkOutline,
        outlineVariant: _darkOutlineVariant,
      );
    } else {
      return const ColorScheme.light(
        primary: _lightPrimary,
        onPrimary: _lightOnPrimary,
        primaryContainer: _lightPrimaryContainer,
        onPrimaryContainer: _lightOnPrimaryContainer,
        secondary: _lightSecondary,
        onSecondary: _lightOnSecondary,
        secondaryContainer: _lightSecondaryContainer,
        onSecondaryContainer: _lightOnSecondaryContainer,
        tertiary: _lightTertiary,
        onTertiary: _lightOnTertiary,
        tertiaryContainer: _lightTertiaryContainer,
        onTertiaryContainer: _lightOnTertiaryContainer,
        surface: _lightSurface,
        onSurface: _lightOnSurface,
        surfaceContainerHighest: _lightSurfaceVariant,
        onSurfaceVariant: _lightOnSurfaceVariant,
        error: _lightError,
        onError: _lightOnError,
        errorContainer: _lightErrorContainer,
        onErrorContainer: _lightOnErrorContainer,
        outline: _lightOutline,
        outlineVariant: _lightOutlineVariant,
      );
    }
  }
}
