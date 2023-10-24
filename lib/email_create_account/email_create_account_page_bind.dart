import 'package:get/get.dart';

import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'email_create_account_page.dart';

class EmailCreateAccountPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => EmailCreateAccountPageController(Get.find(), Get.find()),
        fenix: true);
  }
}
