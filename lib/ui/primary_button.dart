import 'package:flutter/material.dart';

import 'dimen.dart';
import 'styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key, required this.title, required this.isEnabled, this.onTap});

  final String title;
  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: Dimen.buttonHeight, minWidth: Dimen.buttonWidth),
          child: ElevatedButton(
              onPressed: isEnabled ? onTap : null,
              style: GreenOvalButtonStyle(isEnabled: isEnabled),
              clipBehavior: Clip.hardEdge,
              child: Text(title, style: ApplicationTextStyles.buttonTextStyle,))),
    );
  }
}
