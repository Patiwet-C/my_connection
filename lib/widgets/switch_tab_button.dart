import 'package:flutter/material.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';

/// This widget fixed only 2 button
class SwitchTabButton extends StatelessWidget {
  final TabController controller;
  final Function(int) onTap;
  final TextStyle? labelStyle;
  final String firstLabel;
  final String secondLabel;

  const SwitchTabButton({
    super.key,
    required this.controller,
    required this.onTap,
    this.labelStyle,
    required this.firstLabel,
    required this.secondLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColour.primary, width: 1.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TabBar(
        controller: controller,
        padding: const EdgeInsets.all(4),
        indicator: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColour.shadowColour,
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColour.shadowMedium, width: 0.5),
          borderRadius: BorderRadius.circular(7.0),
          color: AppColour.primary,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColour.white,
        unselectedLabelColor: AppColour.secondary,
        onTap: onTap,
        labelStyle: labelStyle ?? AppTextStyles.get().body2,
        tabs: [
          Center(child: Tab(text: firstLabel)),
          Center(child: Tab(text: secondLabel)),
        ],
      ),
    );
  }
}
