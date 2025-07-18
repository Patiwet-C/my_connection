import 'package:flutter/material.dart';
import 'package:my_connection/app.dart';
import 'package:my_connection/base/init.dart';
import 'package:my_connection/i18n/strings.g.dart';

void main() async {
  await Init.instance.initialize();

  runApp(TranslationProvider(child: const MyConnectionApp()));
}
