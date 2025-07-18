import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  // content without SafeArea
  double get contentHeight => mediaQuery.size.height - screenPadding.top - screenPadding.bottom;

  double get screenHeight => mediaQuery.size.height;

  double get screenWidth => mediaQuery.size.width;

  EdgeInsets get screenPadding => mediaQuery.padding;

  bool get isSmallDevice => mediaQuery.size.height <= 736; // 414 x 736 are viewport of IP 8 Plus

  bool get isLargeDevice =>
      mediaQuery.size.height >= 844; // 390 x 844 are viewport of IP 13 Pro Max

  // if there is no currently keyboard on focus this view return 0
  double get keyBoardHeight => mediaQuery.viewInsets.bottom;
}

extension FocusScopeExtension on BuildContext {
  void unFocusCurrentKeyboard() {
    if (FocusScope.of(this).hasFocus) {
      FocusScope.of(this).unfocus();
    }
  }
}
