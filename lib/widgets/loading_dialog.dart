import 'package:flutter/material.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';

class LoadingDialog extends StatelessWidget {
  final Color backdropColor;
  final Function()? onCancel;

  const LoadingDialog({
    super.key,
    this.backdropColor = Colors.black54,
    this.onCancel,
  });

  static Widget stream(
    Stream<bool> stream, {
    Function(bool)? onChanged,
    Function()? onCancel,
    Color? backdropColor,
  }) {
    return StreamBuilder<bool>(
      stream: stream,
      initialData: false,
      builder: (ctx, snapshot) {
        if (onChanged != null) {
          onChanged(snapshot.data!);
        }
        return snapshot.data == false
            ? const SizedBox(height: 0, width: 0)
            : LoadingDialog(
                backdropColor: backdropColor ?? Colors.black54,
                onCancel: onCancel,
              );
      },
    );
  }

  static Widget loadingWidget() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black.withAlpha(0xBF),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 42,
              height: 42,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          OverflowBox(
            alignment: Alignment.center,
            minWidth: screenSize.width + 150.0,
            minHeight: screenSize.height + 150.0,
            maxWidth: screenSize.width + 150.0,
            maxHeight: screenSize.height + 150.0,
            child: Container(
              color: backdropColor,
              child: Center(child: loadingWidget()),
            ),
          ),
          if (onCancel != null)
            Positioned(
              bottom: 24,
              left: (screenSize.width / 2) - 16,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onTap: () async {
                  // if (getIt.isRegistered<CancelToken>()) {
                  //   final cancelToken = getIt<CancelToken>();
                  //   cancelToken.cancel();
                  //   onCancel?.call();

                  //   getIt.unregister<CancelToken>();
                  //   getIt.registerLazySingleton<CancelToken>(
                  //     () => CancelToken(),
                  //   );
                  // }
                },
                child: Text(
                  t.button.cancel,
                  style: AppTextStyles.get().caption2.copyWith(
                    color: AppColour.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
