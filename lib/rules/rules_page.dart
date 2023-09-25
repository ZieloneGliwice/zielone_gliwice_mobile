import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class RulesPage extends GetView<RulesPageController> {
  const RulesPage({super.key});
  static const String path = '/rules_page';

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
                  Text('test rules'),
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

class RulesPageController extends GetxController {
  RulesPageController();

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
