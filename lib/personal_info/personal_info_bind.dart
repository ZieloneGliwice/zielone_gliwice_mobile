import 'package:get/get.dart';

import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'personal_info_page.dart';

class PersonalInfoPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => PersonalInfoPageController(Get.find(), Get.find()),
        fenix: true);
  }
}
