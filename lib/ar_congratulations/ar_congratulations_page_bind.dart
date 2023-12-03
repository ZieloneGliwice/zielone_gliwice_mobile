import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'ar_congratulations_page.dart';

class ArCongratulationsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => ArCongratulationsController(Get.find(), Get.find()),
        fenix: true);
  }
}
