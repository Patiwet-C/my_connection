import 'package:flutter/material.dart';
import 'package:my_connection/styles/app_colour.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColour.onPrimary,
      activeTrackColor: AppColour.primary,
      inactiveThumbColor: AppColour.onSecondary,
      inactiveTrackColor: AppColour.secondary,
    );
  }
}
