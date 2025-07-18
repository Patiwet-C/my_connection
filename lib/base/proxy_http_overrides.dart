import 'dart:io';

import 'package:my_connection/constants/app_constants.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:system_proxy/system_proxy.dart';

class ProxyHttpOverrides extends HttpOverrides {
  final String? _port;
  final String? _host;

  ProxyHttpOverrides(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final appConstants = getIt<AppConstants>();
    final shouldProxyEnable =
        _host != null &&
        (appConstants.envName == AppEnvironment.develop ||
            appConstants.envName == AppEnvironment.staging);
    return super.createHttpClient(context)
      // set proxy
      ..findProxy = (uri) {
        return shouldProxyEnable ? 'PROXY $_host:$_port;' : 'DIRECT';
      }
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => Platform.isAndroid);
  }

  static Future<void> overrideWithSystemProxy() async {
    Map<String, String?>? proxy = await SystemProxy.getProxySettings();
    proxy ??= {'host': null, 'port': null};
    HttpOverrides.global = ProxyHttpOverrides(proxy['host'], proxy['port']);
  }
}
