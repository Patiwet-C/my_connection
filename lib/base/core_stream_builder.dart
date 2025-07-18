import 'package:flutter/material.dart';

typedef CoreStreamShouldRebuild<T> = bool Function(T?, T?);

class CoreStreamBuilder<T> extends StatefulWidget {
  final Stream<T> stream;
  final T? initialData;
  final AsyncWidgetBuilder<T> builder;
  final CoreStreamShouldRebuild<T>? shouldRebuild;

  const CoreStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
    this.initialData,
    this.shouldRebuild,
  });

  @override
  State<StatefulWidget> createState() => _CoreStreamBuilderState<T>();
}

class _CoreStreamBuilderState<T> extends State<CoreStreamBuilder<T>> {
  T? _oldData;
  Widget? _oldWidget;

  bool _defaultShouldRebuild(T? previousValue, T? nextValue) {
    return previousValue != nextValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        final newData = snapshot.data;
        final oldWidget = _oldWidget;
        final shouldRebuild = widget.shouldRebuild ?? _defaultShouldRebuild;

        if (_oldData != null && oldWidget != null && !shouldRebuild(_oldData, newData)) {
          return oldWidget;
        }

        _oldData = newData;
        final newWidget = Builder(
          builder: (BuildContext context) {
            return widget.builder(context, snapshot);
          },
        );

        _oldWidget = newWidget;
        return newWidget;
      },
      initialData: widget.initialData,
      stream: widget.stream,
    );
  }
}
