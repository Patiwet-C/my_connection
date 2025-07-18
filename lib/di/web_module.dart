import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:injectable/injectable.dart';

/// Web-specific module for handling web platform dependencies
@module
abstract class WebModule {
  /// Check if running on web platform
  @lazySingleton
  bool get isWeb => kIsWeb;

  /// Web-specific configurations can be added here
  /// For example, web-specific storage, network configurations, etc.
}
