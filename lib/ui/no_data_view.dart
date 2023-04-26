import 'package:flutter/material.dart';

import 'dimen.dart';
import 'primary_button.dart';
import 'styles.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.iconSize = Dimen.placeholderSize, this.spacing = Dimen.marginNormal, this.minButtonHeight = 40, this.icon, this.header, this.title, this.message, this.buttonTitle, this.onPressed});

  final double iconSize;
  final double spacing;
  final double minButtonHeight;
  final IconData? icon;
  final String? header;
  final String? title;
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
    return icon != null ? Icon(icon, size: iconSize, color: ApplicationColors.green) : null;
  }

  Widget? _header() {
    return header != null ? Text(header!, style: ApplicationTextStyles.headerTextStyle) : null;
  }

  Widget? _message() {
    if (title != null || message != null) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            style: ApplicationTextStyles.descriptionTextStyle,
            children: <TextSpan>[
              if (title != null) ... <TextSpan>{
                TextSpan(text: '$title\n', style: ApplicationTextStyles.descriptionBoldTextStyle)
              },
              if (message != null) ... <TextSpan>{
                TextSpan(text: message)
              }
            ]
        ),
      );
    } else {
      return null;
    }
  }

  Widget? _button() {
    if (buttonTitle != null && onPressed != null) {
      return Padding(
        padding: EdgeInsets.only(top: spacing),
        child: PrimaryButton(title: buttonTitle!, isEnabled: true, onTap: onPressed)
      );
    } else {
      return null;
    }
  }
}
