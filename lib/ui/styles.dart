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
  static const TextStyle buttonTextStyle = TextStyle(color: ApplicationColors.white, fontWeight: FontWeight.w600, fontSize: 17.0, height: 22);
}

// Colors
abstract class ApplicationColors {
  static const Color green = Color(0xFF95C122);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF222222);
}