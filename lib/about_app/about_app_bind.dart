import 'package:get/get.dart';

import 'about_app_page.dart';

class AboutAppBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutAppPageController(), fenix: true);
  }
}
