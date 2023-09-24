import 'package:get/get.dart';

import '../utils/session_storage.dart';
import 'personal_info_page.dart';

class PersonalInfoPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => PersonalInfoPageController(Get.find()), fenix: true);
  }
}
