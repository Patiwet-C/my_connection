import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/features/auth/pages/authentication_page.dart';
import 'package:my_connection/routers/navable.dart';

@Named(RouterName.authenticationPage)
@Injectable(as: NavAble)
class AuthenticationNavigator implements NavAble {
  @override
  Widget get(argument) => const AuthenticationPage();
}
