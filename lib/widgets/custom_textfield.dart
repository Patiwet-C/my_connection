import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_connection/base/base_stateless.dart';
import 'package:my_connection/styles/app_colour.dart';

class CustomTextField extends BaseStateless {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? obscureText;
  final Function()? onObscureIconPressed;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.onObscureIconPressed,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: AppColour.textFieldText),
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColour.textFieldLabel),
        hintText: hint,
        hintStyle: TextStyle(color: AppColour.textFieldHint),
        filled: true,
        fillColor: AppColour.textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColour.textFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColour.textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColour.textFieldFocusedBorder,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColour.textFieldErrorBorder),
        ),
        suffixIcon: obscureText != null
            ? IconButton(
                onPressed: onObscureIconPressed,
                icon: Icon(
                  obscureText! ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
