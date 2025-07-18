import 'package:flutter/material.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/text_styles.dart';

abstract class AppTextTheme {
  TextStyle get headline1;
  TextStyle get headline2;
  TextStyle get subtitle1;
  TextStyle get subtitle2;
  TextStyle get subtitle2Bold;
  TextStyle get subtitle3;
  TextStyle get body1;
  TextStyle get body1Bold;
  TextStyle get body2;
  TextStyle get body2Bold;
  TextStyle get caption1;
  TextStyle get caption1Bold;
  TextStyle get caption2;
  TextStyle get caption2Bold;
  TextStyle get caption3;
  TextStyle get btnL;
  TextStyle get btnM;
  TextStyle get btnS;
  TextStyle get btnXS;
  TextStyle get medium;
  TextStyle get small;
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyles get() {
    final locale = LocaleSettings.currentLocale;
    switch (locale) {
      case AppLocale.th:
        return TextStyles();
      default:
        return TextStyles();
    }
  }
}
