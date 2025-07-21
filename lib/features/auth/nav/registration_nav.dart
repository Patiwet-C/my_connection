import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_connection/constants/router_name.dart';
import 'package:my_connection/features/auth/pages/registration_page.dart';
import 'package:my_connection/routers/navable.dart';

@Named(RouterName.registrationPage)
@Injectable(as: NavAble)
class RegistrationNavigator implements NavAble {
  @override
  Widget get(argument) => const RegistrationPage();
}
