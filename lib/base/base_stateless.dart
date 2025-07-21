import 'package:flutter/material.dart';
import 'package:my_connection/i18n/strings.g.dart';
import 'package:my_connection/styles/app_text_styles.dart';
import 'package:my_connection/styles/text_styles.dart';

abstract class BaseStateless extends StatelessWidget {
  const BaseStateless({super.key});

  TextStyles get styles => AppTextStyles.get();
  Translations get translations => t;
}
