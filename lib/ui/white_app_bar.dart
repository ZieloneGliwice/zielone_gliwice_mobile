import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../settings/settings_page.dart';
import 'styles.dart';

class WhiteAppBar extends AppBar {
  WhiteAppBar({super.key, super.title, this.photoURL})
      : super(
          backgroundColor: ApplicationColors.white,
          elevation: 0,
          foregroundColor: ApplicationColors.gray,
          titleTextStyle: ApplicationTextStyles.appBarTitleTextStyle,
          centerTitle: true,
          shape: const Border(
            bottom: BorderSide(
              color: ApplicationColors.gray,
              width: 0.2,
            ),
          ),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[const SizedBox(width: 15), _logo()],
          ),
          actions: <Widget>[
            Obx(() => _photo(photoURL)),
            const SizedBox(
              width: 17,
            )
          ],
        );

  final RxString? photoURL;
}

Widget _photo(RxString? photoURL) {
  if (photoURL != null && photoURL.isNotEmpty) {
    return InkWell(
      onTap: () => viewSettings(),
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: const Border(
            top: BorderSide(color: ApplicationColors.black),
            left: BorderSide(color: ApplicationColors.black),
            right: BorderSide(color: ApplicationColors.black),
            bottom: BorderSide(color: ApplicationColors.black),
          ),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(photoURL.value),
          ),
        ),
      ),
    );
  } else {
    return InkWell(
      onTap: () => viewSettings(),
      child: const SizedBox(
        width: 43,
        height: 43,
        child: Icon(
          Icons.account_circle_rounded,
          size: 43,
        ),
      ),
    );
  }
}

Widget _logo() {
  const String assetName = 'assets/images/leaf_logo.png';
  return const Image(
    image: AssetImage(assetName),
    width: 40,
    height: 40,
  );
}

void viewSettings() {
  Get.toNamed(SettingsPage.path);
}
