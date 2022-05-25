import 'package:flutter/material.dart';

// Buttons
class GreenOvalButtonStyle extends ButtonStyle {
  GreenOvalButtonStyle({this.isEnabled = true}) : super(
      textStyle: MaterialStateProperty.all<TextStyle>(ApplicationTextStyles.buttonTextStyle),
      foregroundColor: MaterialStateProperty.all<Color>(isEnabled ? ApplicationColors.white : ApplicationColors.disabledWhite),
      backgroundColor: MaterialStateProperty.all<Color>(isEnabled ? ApplicationColors.green : ApplicationColors.disabledGreen),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: isEnabled ? ApplicationColors.green : ApplicationColors.disabledGreen)
          )
      ));
  final bool isEnabled;
}

class WhiteOvalButtonStyle extends ButtonStyle {
  WhiteOvalButtonStyle() : super(
      textStyle: MaterialStateProperty.all<TextStyle>(ApplicationTextStyles.buttonTextStyle),
      foregroundColor: MaterialStateProperty.all<Color>(ApplicationColors.black),
      backgroundColor: MaterialStateProperty.all<Color>(ApplicationColors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: const BorderSide(color: ApplicationColors.white)
          )
      ));
}

class PhotoPlaceholderButtonStyle extends ButtonStyle {
  PhotoPlaceholderButtonStyle() : super(
      foregroundColor: MaterialStateProperty.all<Color>(ApplicationColors.white),
      backgroundColor: MaterialStateProperty.all<Color>(ApplicationColors.lightSilver),
      padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.zero),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          )
      ));
}

// TextStyles
abstract class ApplicationTextStyles {
  static const String _poppinsFont = 'Poppins';

  static const TextStyle textButtonTextStyle = TextStyle(color: ApplicationColors.yellow, fontWeight: FontWeight.w500, fontSize: 14.0, fontFamily: _poppinsFont);
  static const TextStyle buttonTextStyle = TextStyle(color: ApplicationColors.white, fontWeight: FontWeight.w600, fontSize: 17.0, fontFamily: _poppinsFont);
  static const TextStyle appBarTitleTextStyle = TextStyle(color: ApplicationColors.black, fontWeight: FontWeight.w700, fontSize: 17.0, fontFamily: _poppinsFont);
  static const TextStyle headerTextStyle = TextStyle(color: ApplicationColors.black, fontWeight: FontWeight.w400, fontSize: 25.0, fontFamily: _poppinsFont);
  static const TextStyle bodyBoldTextStyle = TextStyle(color: ApplicationColors.gray, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: _poppinsFont);
  static const TextStyle bodyTextStyle = TextStyle(color: ApplicationColors.gray, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: _poppinsFont);

  static const TextStyle unselectedLabelStyle = TextStyle(color: ApplicationColors.gray, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: _poppinsFont);
  static const TextStyle selectedLabelStyle = TextStyle(color: ApplicationColors.green, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: _poppinsFont);
}

// Colors
abstract class ApplicationColors {
  static const Color green = Color(0xFF95C122);
  static const Color disabledGreen = Color(0x3395C122);
  static const Color white = Color(0xFFFFFFFF);
  static const Color disabledWhite = Color(0x33FFFFFF);
  static const Color black = Color(0xFF222222);
  static const Color gray = Color(0xFF7B7B7B);
  static const Color lightGray = Color(0xFFEFEFEF);
  static const Color background = Color(0xFFF6F6F6);
  static const Color red = Color(0xFFFF0000);
  static const Color orange = Color(0xFFFF7A00);
  static const Color lightSilver = Color(0xFFD9D9D9);
  static const Color yellow = Color(0xFFFFD600);
}

