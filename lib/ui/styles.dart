import 'package:flutter/material.dart';

// Buttons
class GreenOvalButtonStyle extends ButtonStyle {
  GreenOvalButtonStyle() : super(
      textStyle: MaterialStateProperty.all<TextStyle>(ApplicationTextStyles.buttonTextStyle),
      foregroundColor: MaterialStateProperty.all<Color>(ApplicationColors.white),
      backgroundColor: MaterialStateProperty.all<Color>(ApplicationColors.green),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: ApplicationColors.green)
          )
      ));
}

class BlackOvalButtonStyle extends ButtonStyle {
  BlackOvalButtonStyle() : super(
      textStyle: MaterialStateProperty.all<TextStyle>(ApplicationTextStyles.buttonTextStyle),
      foregroundColor: MaterialStateProperty.all<Color>(ApplicationColors.white),
      backgroundColor: MaterialStateProperty.all<Color>(ApplicationColors.black),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: ApplicationColors.black)
          )
      ));
}

// TextStyles
abstract class ApplicationTextStyles {
  static const TextStyle buttonTextStyle = TextStyle(color: ApplicationColors.white, fontWeight: FontWeight.w600, fontSize: 17.0);
  static const TextStyle appBarTitleTextStyle = TextStyle(color: ApplicationColors.black, fontWeight: FontWeight.w800, fontSize: 17.0, fontFamily: 'Poppins');
  static const TextStyle headerTextStyle = TextStyle(color: ApplicationColors.black, fontWeight: FontWeight.w400, fontSize: 25.0, fontFamily: 'Poppins');
  static const TextStyle bodyBoldTextStyle = TextStyle(color: ApplicationColors.gray, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins');
  static const TextStyle bodyTextStyle = TextStyle(color: ApplicationColors.gray, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'Poppins');
}

// Colors
abstract class ApplicationColors {
  static const Color green = Color(0xFF95C122);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF222222);
  static const Color gray = Color(0xFF7B7B7B);
  static const Color background = Color(0xFFF6F6F6);
}