import 'package:flutter/material.dart';
import 'package:my_connection/generated/assets.gen.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/widgets/hgap.dart';

enum ToastType { error, success, alert }

class CustomToastDialog {
  static void showToastMessage({
    required final BuildContext context,
    required final ToastType type,
    final String? title,
    final String? message,
    final Widget? icon,
    final Duration duration = const Duration(milliseconds: 1500),
    final double elevation = 0,
    final SnackBarBehavior behavior = SnackBarBehavior.floating,
    final Color backgroundCOlor = Colors.transparent,
    final EdgeInsets margin = const EdgeInsets.only(bottom: 10),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        elevation: elevation,
        behavior: behavior,
        backgroundColor: backgroundCOlor,
        margin: margin,
        content: _ToastMessage(
          message: message ?? '',
          title: title,
          type: type,
          icon: icon,
        ),
      ),
    );
  }
}

class _ToastMessage extends StatelessWidget {
  final String message;
  final ToastType type;
  final String? title;
  final Widget? icon;

  const _ToastMessage({
    required this.message,
    required this.type,
    this.title,
    this.icon,
  });

  Color get toastColor {
    switch (type) {
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      case ToastType.alert:
        return Colors.yellow;
    }
  }

  SvgGenImage get defaultIcon {
    switch (type) {
      case ToastType.error:
        return Assets.svg.icAlert;
      case ToastType.success:
        return Assets.svg.icTickCircle;
      case ToastType.alert:
        return Assets.svg.icInfo;
    }
  }

  Color get textColor {
    switch (type) {
      case ToastType.error:
        return Colors.white;
      case ToastType.success:
        return Colors.white;
      case ToastType.alert:
        return Colors.white;
    }
  }

  Color get backgroundColor {
    switch (type) {
      case ToastType.error:
        return Colors.red;
      case ToastType.success:
        return Colors.green;
      case ToastType.alert:
        return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles.get();

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: toastColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon ??
                defaultIcon.svg(
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
            const HGap(16),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: styles.caption1Bold.copyWith(color: textColor),
                ),
              ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: styles.caption1.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
