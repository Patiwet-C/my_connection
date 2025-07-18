import 'package:flutter/material.dart';
import 'package:my_connection/base/core_stream_builder.dart';
import 'package:rxdart/rxdart.dart';

class ValueStreamBuilder<T> extends StatelessWidget {
  final ValueStream<T> stream;
  final AsyncWidgetBuilder<T> builder;
  final CoreStreamShouldRebuild<T>? shouldRebuild;

  const ValueStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
    this.shouldRebuild,
  });

  @override
  Widget build(BuildContext context) {
    return CoreStreamBuilder<T>(
      stream: stream,
      builder: builder,
      initialData: stream.valueOrNull,
      shouldRebuild: shouldRebuild,
    );
  }
}
