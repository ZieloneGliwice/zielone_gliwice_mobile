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
                  Text('test about'),
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

class AboutAppPageController extends GetxController {
  AboutAppPageController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
