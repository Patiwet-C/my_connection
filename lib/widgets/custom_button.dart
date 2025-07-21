import 'package:flutter/material.dart';
import 'package:my_connection/base/base_stateless.dart';
import 'package:my_connection/styles/app_colour.dart';

class CustomButton extends BaseStateless {
  final String label;
  final VoidCallback onPressed;
  final bool? isFullWidth;
  final bool? isSecondary;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFullWidth = true,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth == true ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary == true
              ? AppColour.secondary
              : AppColour.primary,
          foregroundColor: isSecondary == true
              ? AppColour.onSecondary
              : AppColour.onPrimary,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: styles.body1.copyWith(
            color: isSecondary == true
                ? AppColour.onSecondary
                : AppColour.onPrimary,
          ),
        ),
      ),
    );
  }
}
