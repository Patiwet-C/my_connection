import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_connection/constants/app_constants.dart';

class EnvironmentWrapper {
  static const String _packageName = String.fromEnvironment('flavor');

  static AppEnvironment getEnv() {
    switch (_packageName) {
      case 'develop':
        return AppEnvironment.develop;
      case 'staging':
        return AppEnvironment.staging;
      default:
        return AppEnvironment.production;
    }
  }

  static Future<void> loadEnvironmentVariables(AppEnvironment env) async {
    switch (env) {
      case AppEnvironment.develop:
        return dotenv.load(fileName: 'develop.env');
      case AppEnvironment.staging:
        return dotenv.load(fileName: 'staging.env');
      default:
        return dotenv.load(fileName: 'production.env');
    }
  }

  static String get(String key) {
    return dotenv.env[key] ?? '';
  }
}
