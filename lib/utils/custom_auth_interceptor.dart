import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/di/dio_client.dart';
import 'package:my_connection/routers/app_navigator.dart';

@injectable
class CustomAuthInterceptor extends Interceptor {
  final DioClient? dio;
  final AppNavigator appNavigator;

  CustomAuthInterceptor(@factoryParam this.dio, this.appNavigator);

  // The number of retries in case of 401
  final int retries = 2;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authToken = '';

    if (authToken.isNotEmpty) {
      final String authTokenValue = authToken;
      final RequestOptions request =
          options.._setAuthenticationHeader(authTokenValue);
      super.onRequest(request, handler);
    } else {
      final error = DioException(
        requestOptions: options,
        type: DioExceptionType.unknown,
      );
      handler.reject(error);
    }
  }

  Future<void> _fetchNewToken(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final accessToken = '';

    if (accessToken.isNotEmpty) {
      final currentAttempt = error.requestOptions._retryAttempt + 1;
      final accessTokenValue = accessToken;
      final requestOptions =
          error.requestOptions.._retryAttempt = currentAttempt;
      requestOptions._setAuthenticationHeader(accessTokenValue);
      try {
        await dio!.client.fetch(requestOptions).then((value) {
          handler.resolve(value);
        });
      } on DioException catch (e) {
        super.onError(e, handler);
      }
    } else {
      final BuildContext? context = appNavigator.currentState?.context;
      final int? statusCode = error.response?.statusCode;

      if (statusCode == 401 && context != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SizedBox.shrink();
          },
        );
      }
      handler.reject(error);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    if (statusCode != 401 || dio == null) {
      return super.onError(err, handler);
    }

    if (err.requestOptions._retryAttempt + 1 < retries) {
      _fetchNewToken(err, handler);
    } else {
      handler.reject(err);
    }
  }
}

extension AuthRequestOptions on RequestOptions {
  void _setAuthenticationHeader(final String token) =>
      headers['Authorization'] = 'Bearer $token';

  int get _retryAttempt => (extra['auth_retry_attempt'] as int?) ?? 0;

  set _retryAttempt(final int attempt) => extra['auth_retry_attempt'] = attempt;
}
