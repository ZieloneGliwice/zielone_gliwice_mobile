import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class PrivacyPolicyPage extends GetView<PrivacyPolicyPageController> {
  const PrivacyPolicyPage({super.key});
  static const String path = '/privacy_policy_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('privacy_policy'.tr),
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
                  const SizedBox(height: 20),
                  Text(
                    'privacy_policy_content'.tr,
                    style: ApplicationTextStyles.privacyPolicyContentTextStyle,
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

class PrivacyPolicyPageController extends GetxController {
  PrivacyPolicyPageController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
