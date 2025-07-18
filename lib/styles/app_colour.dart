import 'package:flutter/material.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/utils/local_storage.dart';

class AppColour {
  AppColour._();

  // light mode colours - blue and white theme
  static const Color _lightPrimary = Color(0xFF2196F3);
  static const Color _lightSecondary = Color(0xFF64B5F6);
  static const Color _lightPrimaryText = Color(0xFF1976D2);
  static const Color _lightSecondaryText = Color(0xFF424242);
  static const Color _lightPrimaryButton = Color(0xFF2196F3);
  static const Color _lightSecondaryButton = Color(0xFFE3F2FD);

  // dark mode colours - dark blue and grey theme
  static const Color _darkPrimary = Color(0xFF1565C0);
  static const Color _darkSecondary = Color(0xFF42A5F5);
  static const Color _darkPrimaryText = Color(0xFFFFFFFF);
  static const Color _darkSecondaryText = Color(0xFFBDBDBD);
  static const Color _darkPrimaryButton = Color(0xFF1565C0);
  static const Color _darkSecondaryButton = Color(0xFF424242);

  static Color get primary => _getColour(_lightPrimary, _darkPrimary);
  static Color get secondary => _getColour(_lightSecondary, _darkSecondary);
  static Color get primaryText =>
      _getColour(_lightPrimaryText, _darkPrimaryText);
  static Color get secondaryText =>
      _getColour(_lightSecondaryText, _darkSecondaryText);
  static Color get primaryButton =>
      _getColour(_lightPrimaryButton, _darkPrimaryButton);
  static Color get secondaryButton =>
      _getColour(_lightSecondaryButton, _darkSecondaryButton);

  // Common colours (not theme-dependent)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Shadow colours
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  static const Color shadowColour = Color(0x1F000000);

  static Color _getColour(Color lightColour, Color darkColour) {
    final storage = getIt<LocalStorage>();

    if (storage.getCachedData<bool>(StorageKey.darkModeSetting) ?? false) {
      return darkColour;
    }
    return lightColour;
  }
}
