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
      appBar: GrayAppBar(),
      backgroundColor: ApplicationColors.background,
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Text('test privacy'),
                ],
              ),
            ),
          ],
        ),
      ),
      //not working
      //   bottomNavigationBar: BottomAppBar(
      //       elevation: 0,
      //       color: Colors.transparent,
      //       child: Obx(() => _appVersion())),
    );
  }
}

class PrivacyPolicyPageController extends GetxController {
  PrivacyPolicyPageController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
