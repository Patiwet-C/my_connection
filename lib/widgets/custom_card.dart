import 'package:flutter/material.dart';
import 'package:my_connection/base/base_stateless.dart';
import 'package:my_connection/styles/app_colour.dart';

class CustomCard extends BaseStateless {
  const CustomCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColour.card,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColour.cardBorder, width: 1),
      ),
      child: child,
    );
  }
}
