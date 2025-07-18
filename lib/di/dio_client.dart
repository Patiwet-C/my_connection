import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/utils/custom_auth_interceptor.dart';
import 'package:my_connection/utils/logger_mixin.dart';

export 'package:dio/dio.dart';

@singleton
class DioClient with BuiltInLogger {
  static Dio? _dio;

  DioClient() {
    logger.v('init DioClient');
  }

  Dio get client => _dio ??= _initClient();

  Dio _initClient() =>
      Dio()..interceptors.addAll([getIt<CustomAuthInterceptor>(param1: this)]);
}
