import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_connection/app.dart';
import 'package:my_connection/constants/default_values.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/utils/environment_util.dart';
import 'package:my_connection/utils/logger_mixin.dart';
import 'package:my_connection/utils/remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum AppEnvironment { develop, staging, production }

class AppConstants with BuiltInLogger {
  final AppEnvironment envName;
  final String appVersion;
  final int buildNumber;

  AppConstants({
    required this.envName,
    required this.appVersion,
    required this.buildNumber,
  });

  static Future<AppConstants> initialized(PackageInfo packageInfo) async {
    try {
      final env = EnvironmentWrapper.getEnv();

      return AppConstants(
        envName: env,
        appVersion: packageInfo.version,
        buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error initializing AppConstants: $e');
      }
      rethrow;
    }
  }

  void setTheme(bool isDarkMode) {
    final BuildContext currentContext =
        getIt<AppNavigator>().currentState!.context;

    MyConnectionApp.of(currentContext).changeTheme(isDarkMode);
  }

  String getAppInfo() {
    switch (envName) {
      case AppEnvironment.production:
        return 'v$appVersion ($buildNumber)';
      case AppEnvironment.staging:
        return 'Staging: v$appVersion ($buildNumber)';
      default:
        return 'Dev: v$appVersion ($buildNumber)';
    }
  }

  String getBaseUrl() {
    switch (envName) {
      case AppEnvironment.production:
        return 'production';
      case AppEnvironment.staging:
        return 'https://api-staging.nonprod.hops.is';
      default:
        try {
          final url = getIt<RemoteConfig>().getString(DefaultValues.apiBaseUrl);
          return url;
        } catch (e) {
          return 'http://localhost:8081';
        }
    }
  }
}

extension AppEnvironmentValue on AppEnvironment {
  String get value {
    switch (this) {
      case AppEnvironment.production:
        return 'production';
      case AppEnvironment.staging:
        return 'staging';
      default:
        return 'develop';
    }
  }
}
