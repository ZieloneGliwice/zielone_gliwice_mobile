import 'package:flutter/material.dart';

import 'styles.dart';

class GrayAppBar extends AppBar {
  GrayAppBar({super.key, super.title, this.photoURL})
      : super(
            backgroundColor: ApplicationColors.background,
            elevation: 0,
            foregroundColor: ApplicationColors.gray,
            titleTextStyle: ApplicationTextStyles.appBarTitleTextStyle,
            actions: <Widget>[
              if (photoURL != null && photoURL.isNotEmpty) ...<Widget>{
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(photoURL))),
                ),
                const SizedBox(
                  width: 17,
                )
              }
            ]);

  final String? photoURL;
}
