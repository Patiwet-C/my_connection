import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/constants/storage_key.dart';
import 'package:my_connection/di/configure_dependencies.dart';
import 'package:my_connection/routers/app_navigator.dart';
import 'package:my_connection/routers/app_page_route_builder.dart';
import 'package:my_connection/routers/navable.dart';
import 'package:my_connection/utils/local_storage.dart';

@singleton
class NavigationRouter {
  static Route<dynamic>? router(RouteSettings settings) {
    var routeName = settings.name ?? '/';
    final appNavigatorConfiguration =
        settings.arguments as AppNavigatorConfiguration?;

    if (routeName == '/') {
      final accessToken = getIt<LocalStorage>().getCachedData(
        StorageKey.accessToken,
      );
      if (accessToken != null) {
        routeName = RouterName.homePage;
      } else {
        routeName = RouterName.authenticationPage;
      }
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
