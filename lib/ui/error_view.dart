import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/errors.dart';
import 'dimen.dart';
import 'primary_button.dart';
import 'styles.dart';

class ErrorView extends StatelessWidget {
  factory ErrorView.from(ZGError error, VoidCallback? onPressed, {String? buttonTitle}) {
    return ErrorView._(
      icon: error.icon,
      header: error.title,
      message: error.message,
      buttonTitle: buttonTitle,
      onPressed: onPressed,
    );
  }

  const ErrorView._({super.key, this.spacing = Dimen.marginNormal, this.minButtonHeight = 40, this.icon, this.header, this.message, this.buttonTitle, this.onPressed});

  final double spacing;
  final double minButtonHeight;
  final IconData? icon;
  final String? header;
  final String? message;
  final String? buttonTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = <Widget?>[_image(), _header(), _message(), _button()].whereType<Widget>().toList();

    return Center(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.zero,
              child: Center(child: content[index])
          ),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: spacing,
          ),
          itemCount: content.length
      ),
    );
  }

  Widget? _image() {
    return icon != null ? Icon(icon, size: Dimen.placeholderSize, color: ApplicationColors.green) : null;
  }

  Widget? _header() {
    return header != null ? Text(header!, style: ApplicationTextStyles.headerTextStyle) : null;
  }

  Widget? _message() {
    if (message != null) {
      return Text(message!, style: ApplicationTextStyles.descriptionTextStyle, textAlign: TextAlign.center,);
    } else {
      return null;
    }
  }

  Widget? _button() {
    if (onPressed != null) {
      return Padding(
        padding: EdgeInsets.only(top: spacing),
        child: PrimaryButton(title: buttonTitle ?? 'retry'.tr, isEnabled: true, onTap: onPressed,)
      );
    } else {
      return null;
    }
  }
}
