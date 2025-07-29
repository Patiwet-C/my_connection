import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';

abstract class IRemoteConfig {
  String getString(String key);
  bool getBool(String key);
  int getInt(String key);
  double getDouble(String key);
  Map<String, dynamic> getJson(String key);
}

@injectable
class RemoteConfig implements IRemoteConfig {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfig(this._remoteConfig);

  @override
  String getString(String key) {
    final value = _remoteConfig.getString(key);
    return value;
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  @override
  Map<String, dynamic> getJson(String key) {
    return jsonDecode(_remoteConfig.getString(key));
  }
}
