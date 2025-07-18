import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/features/home/pages/home_page.dart';
import 'package:my_connection/routers/navable.dart';

@Named(RouterName.homePage)
@Injectable(as: NavAble)
class HomeNavigator implements NavAble {
  @override
  Widget get(argument) => const HomePage();
}
