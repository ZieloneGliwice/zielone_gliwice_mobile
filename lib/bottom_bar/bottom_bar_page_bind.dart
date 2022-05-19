import 'package:get/get.dart';

import 'bottom_bar_page.dart';

class BottomBarPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarPageController>(() => BottomBarPageController());
  }
}