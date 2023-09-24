import 'package:get/get.dart';

import '../utils/session_storage.dart';
import 'settings_page.dart';

class SettingsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => SettingsPageController(Get.find()), fenix: true);
  }
}
