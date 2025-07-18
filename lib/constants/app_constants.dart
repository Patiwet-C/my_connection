import 'package:flutter/foundation.dart';
import 'package:my_connection/utils/environment_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum AppEnvironment { develop, staging, production }

class AppConstants {
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
      // final iosOauthCLientId = EnvironmentWrapper.get('IOS_OAUTH_CLIENT_ID');
      // final androidOauthCLientId = EnvironmentWrapper.get(
      //   'ANDROID_OAUTH_CLIENT_ID',
      // );
      // final appSecret = EnvironmentWrapper.get('API_APP_SECRET');

      return AppConstants(
        envName: env,
        appVersion: packageInfo.version,
        buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
        // iosOauthClientId: iosOauthCLientId,
        // androidOauthClientId: androidOauthCLientId,
        // appSecret: appSecret,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
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
        return 'https://api-dev.nonprod.hops.is';
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
