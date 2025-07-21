import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:my_connection/base/base_error.dart';
import 'package:my_connection/di/dio_client.dart';
import 'package:my_connection/utils/logger_mixin.dart';

abstract class UseCase<REQUEST, RESPONSE> with BuiltInLogger {
  @protected
  Future<RESPONSE> execute(REQUEST request);

  @mustCallSuper
  @protected
  Future<BaseError> handleApiError(BaseApiError error, REQUEST params) {
    return Future.value(error);
  }

  Future<Result<RESPONSE>> exec(REQUEST params) async {
    try {
      final result = await execute(params);

      logger.v('------------RESULT-----------');
      logger.v('${DateTime.now()}\n${result.toString()}');
      logger.v('-----------------------------');

      return Result<RESPONSE>.value(result);
    } on DioException catch (e) {
      logger.v('got Dio error');
      final error = e.response?.data;

      if (error is BaseApiError) {
        return Result<RESPONSE>.error(await handleApiError(error, params));
      } else if ((error is HandshakeException)) {
        return Result<RESPONSE>.error(UnknownError(error));
      } else {
        final response = e.response;

        if (response != null) {
          return Result<RESPONSE>.error(
            await handleApiError(BaseApiError(response), params),
          );
        }
      }

      return Result<RESPONSE>.error(
        await handleApiError(BaseApiError(e.response), params),
      );
    } catch (e) {
      logger.v('------------ERROR-----------');
      logger.v('${DateTime.now()}\n${e.toString()}');
      logger.v('-----------------------------');
      if (e is BaseError) {
        return Result<RESPONSE>.error(e);
      }
      return Result<RESPONSE>.error(UnknownError(e));
    }
  }

  Stream<Result<RESPONSE>> stream(REQUEST value) => exec(value).asStream();
}
