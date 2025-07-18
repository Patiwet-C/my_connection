import 'package:flutter/material.dart';
import 'package:my_connection/base/core_stream_builder.dart';
import 'package:my_connection/base/value_stream_builder.dart';
import 'package:rxdart/rxdart.dart';

extension StreamWithBuilder<T> on Stream<T> {
  StreamBuilder<T> streamBuilder({
    Key? key,
    T? initialData,
    required AsyncWidgetBuilder<T> builder,
  }) {
    return StreamBuilder<T>(
      initialData: initialData,
      builder: builder,
      stream: this,
      key: key,
    );
  }
}

extension StreamWithValueStreamBuilder<T> on ValueStream<T> {
  ValueStreamBuilder<T> streamBuilder({
    Key? key,
    CoreStreamShouldRebuild<T>? shouldRebuild,
    required AsyncWidgetBuilder<T> builder,
  }) {
    return ValueStreamBuilder<T>(
      stream: this,
      builder: builder,
      shouldRebuild: shouldRebuild,
    );
  }
}
