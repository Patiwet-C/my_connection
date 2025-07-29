import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:my_connection/base/proxy_http_overrides.dart';
import 'package:my_connection/constants/app_constants.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/firebase_options.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/utils/custom_log_tree.dart';
import 'package:my_connection/utils/environment_util.dart';
import 'package:my_connection/utils/logger_mixin.dart';

class Init with BuiltInLogger {
  Init._();

  static final instance = Init._();

  bool _setupComplete = false;

  bool get setupComplete => _setupComplete;

  final int _fetchTimeout = 1;
  final int _minimumFetchInterval = 1;

  Future<void> initialize({AppEnvironment? appEnvironment}) async {
    if (!_setupComplete) {
      WidgetsFlutterBinding.ensureInitialized();

      // Setup chrome system
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: AppColour.transparent),
      );
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
      );

      final env = appEnvironment ?? EnvironmentWrapper.getEnv();

      await Future.wait([
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        EnvironmentWrapper.loadEnvironmentVariables(env),
      ]);

      await configureDependencies();

      // await Future.wait([setupProxyOverride(env)]);
      await setupFirebaseRemoteConfig();

      if (kDebugMode) {
        _initFimber();
      }

      _setupComplete = true;
    }
  }

  void _initFimber() {
    print('running in debug mode');
    Fimber.plantTree(CustomLogTree());
    Fimber.d('Test Message');
    Fimber.d('------------');
    Fimber.v('VERBOSE');
    Fimber.i('INFO');
    Fimber.d('DEBUG');
    Fimber.w('WARN');
    Fimber.e('ERROR');
    Fimber.d(' ');
  }

  Future<void> setupProxyOverride(AppEnvironment env) async {
    if (env == AppEnvironment.develop || env == AppEnvironment.staging) {
      await ProxyHttpOverrides.overrideWithSystemProxy();
    }
  }

  Future<void> setupFirebaseRemoteConfig() async {
    final remoteConfig = getIt<FirebaseRemoteConfig>();

    try {
      await remoteConfig.ensureInitialized();
      final json = await rootBundle.loadString(
        'assets/json/default_remote_config.json',
      );

      await remoteConfig.setDefaults(jsonDecode(json));
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(minutes: _fetchTimeout),
          minimumFetchInterval: Duration(minutes: _minimumFetchInterval),
        ),
      );
      await remoteConfig.fetchAndActivate();

      logger.i('Firebase Remote Config initialized successfully');
    } catch (e) {
      logger.e('Error initializing FirebaseRemoteConfig: $e');
      logger.w('Continuing with default remote config values');
    }
  }
}
