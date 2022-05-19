import 'package:flutter/material.dart';

import 'styles.dart';

class GrayAppBar extends AppBar {
  GrayAppBar({super.key, super.title}) : super(
    backgroundColor: ApplicationColors.background,
    elevation: 0,
    titleTextStyle: ApplicationTextStyles.appBarTitleTextStyle
  );
}