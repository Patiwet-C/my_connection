import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_connection/styles/app_colour.dart';
import 'package:my_connection/styles/app_text_styles.dart';

class TextStyles implements AppTextTheme {
  static TextStyle prompt = GoogleFonts.prompt(color: AppColour.grey800);

  @override
  TextStyle get body1 => prompt.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get body1Bold => prompt.copyWith(
    fontSize: 18,
    height: 26 / 18,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get body2 => prompt.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get body2Bold => prompt.copyWith(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get btnL => prompt.copyWith(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get btnM => body2Bold;

  @override
  TextStyle get btnS => prompt.copyWith(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get btnXS => prompt.copyWith(
    fontSize: 10,
    height: 18 / 10,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get caption1 => prompt.copyWith(
    fontSize: 14,
    height: 22 / 14,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get caption1Bold => btnS;

  @override
  TextStyle get caption2 => prompt.copyWith(
    fontSize: 12,
    height: 22 / 12,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get caption2Bold => prompt.copyWith(
    fontSize: 12,
    height: 22 / 12,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get caption3 => prompt.copyWith(
    fontSize: 10,
    height: 16 / 10,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get headline1 => prompt.copyWith(
    fontSize: 48,
    height: 56 / 48,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get headline2 => prompt.copyWith(
    fontSize: 40,
    height: 48 / 40,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get medium => prompt.copyWith(
    fontSize: 16,
    height: 18 / 16,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get small => prompt.copyWith(
    fontSize: 14,
    height: 16 / 14,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get subtitle1 => prompt.copyWith(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get subtitle2 => prompt.copyWith(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get subtitle2Bold => prompt.copyWith(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
  );

  @override
  TextStyle get subtitle3 => prompt.copyWith(
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w700,
  );
}
