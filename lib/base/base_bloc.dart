import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:my_connection/utils/logger_mixin.dart';
import 'package:rxdart/rxdart.dart';

const String genericErrorMessage = 'Something went wrong';

abstract class BaseBloc<I> with BuiltInLogger {
  @protected
  final CompositeSubscription compositeSubscription = CompositeSubscription();

  I get bloc;
  ValueStream<bool> get isLoading;
  Function()? get onCancelLoading => null;

  BaseBloc() {
    logger.v('init bloc');
  }

  /// Implement this inside bloc for handle next item load in lazy loading
  void onLoadNextItems() {}

  void onDispose() {
    logger.d('dispose');
    compositeSubscription.dispose();
  }

  /// Implement this inside bloc in order to initialize variables
  /// This function will be call inside the BaseViewModelState when page is init
  void onInit() {}

  /// Implement this inside bloc in order to called when the current route has been popped off.
  void didPop() {}

  /// Implement this inside bloc in order to called when the top route has been popped off, and the current route shows up.
  void didPopNext() {}

  /// Implement this inside bloc in order to called when the current route has been pushed.
  void didPush() {}

  /// Implement this inside bloc in order to called when a new route has been pushed, and the current route is no longer visible.
  void didPushNext() {}
}

extension ForwardError<T> on Stream<Result<T>> {
  Stream<T> onErrorForwardTo(StreamSink<Object?> onError) {
    return switchMap<T>((value) {
      if (value.isError) {
        final error = value.asError!.error;
        onError.add(error);
        return const Stream.empty();
      }
      return Stream.value(value.asValue!.value);
    });
  }
}

extension BroadcastValueStream<T> on Stream<T> {
  ValueStream<T> asBroadcastValueStream() {
    return publishValue()..connect();
  }
}
