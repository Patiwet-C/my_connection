import 'package:my_connection/data/entities/status_model.dart';
import 'package:my_connection/di/dio_client.dart';

class NoInternetConnection implements Exception {}

class BaseError {
  String code = '';
  String message = '';
  Object? data;
}

class UnknownError extends BaseError {
  final Object object;

  UnknownError(this.object);
}

class BaseApiError extends BaseError {
  final Response? response;

  BaseApiError(this.response);

  @override
  String get code => getCode();

  @override
  String get message => getMessage();

  @override
  Object? get data => getData();

  String getCode() {
    try {
      final statusResponse = StatusResponse.fromJson(response?.data);
      return statusResponse.code.toString();
    } catch (e) {
      return response?.statusCode.toString() ?? '';
    }
  }

  String getMessage() {
    try {
      final responseData = response?.data;
      final statusResponse = StatusResponse.fromJson(responseData);
      return statusResponse.message.toString();
    } catch (e) {
      return response?.statusMessage ?? 'Something went wrong';
    }
  }

  Object? getData() {
    try {
      return response?.data['data'];
    } catch (e) {
      return null;
    }
  }
}
