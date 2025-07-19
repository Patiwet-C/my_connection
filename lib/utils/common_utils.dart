import 'package:my_connection/i18n/strings.g.dart';

class CommonUtils {
  static void changeLanguage(int index) {
    AppLocale language = AppLocale.en;

    switch (index) {
      case 0:
        language = AppLocale.en;
        break;
      case 1:
        language = AppLocale.th;
        break;
    }

    LocaleSettings.setLocale(language);
  }
}
