import 'package:flutter/material.dart';
import 'package:rxdart/utils.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @protected
  final CompositeSubscription compositeSubscription = CompositeSubscription();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    compositeSubscription.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
