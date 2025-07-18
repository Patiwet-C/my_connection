import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/routers/app_page_route_builder.dart';
import 'package:my_connection/routers/navable.dart';

@singleton
class NavigationRouter {
  static Route<dynamic>? router(RouteSettings settings) {
    var routeName = settings.name ?? '/';
    final appNavigatorConfiguration =
        settings.arguments as AppNavigatorConfiguration?;

    if (routeName == '/') {
      routeName = RouterName.homePage;
    } else {
      return null;
    }

    final widget = getIt<NavAble>(
      instanceName: routeName,
    ).get(appNavigatorConfiguration?.arguments);

    return AppPageRouteBuilder.route(
      builder: (BuildContext context) {
        return widget;
      },
      name: routeName,
      transitionType:
          appNavigatorConfiguration?.transition ??
          RouteTransition.slideHorizontal,
    );
  }
}
