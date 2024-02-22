import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'ar_game_page.dart';

class ArGamePageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => ArGameController(Get.find(), Get.find()), fenix: true);
  }
}
