import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class AboutAppPage extends GetView<AboutAppPageController> {
  const AboutAppPage({super.key});
  static const String path = '/about_app_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('about_app'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.marginBig),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  _logo(),
                  const SizedBox(height: 30),
                  Text(
                    'about_app_content'.tr,
                    style: ApplicationTextStyles.aboutappContentTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    const String assetName = 'assets/images/full_logo.png';
    return const Image(image: AssetImage(assetName));
  }
}

class AboutAppPageController extends GetxController {
  AboutAppPageController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
