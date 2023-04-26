import 'package:flutter/material.dart';
import 'styles.dart';

class Date extends StatelessWidget {
  const Date({super.key, required this.dateString});

  final String dateString;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Icon(
        Icons.calendar_today,
        color: ApplicationColors.black,
        size: 10,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(
        dateString,
        style: ApplicationTextStyles.subTitleTextStyle,
      )
    ]);
  }
}
