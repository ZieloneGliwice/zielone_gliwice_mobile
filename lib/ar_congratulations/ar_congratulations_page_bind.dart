import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'ar_congratulations_page.dart';
import 'increment_points_request.dart';
import 'new_entry_request.dart';

class ArCongratulationsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService());
    Get.lazyPut(() => SessionStorage());
    Get.lazyPut(() => ApiDio());
    Get.lazyPut(() => NewEntryRequest(SessionStorage(), ApiDio()));
    Get.lazyPut(() => IncrementPointsRequest(SessionStorage(), ApiDio()));

    Get.lazyPut(() => ArCongratulationsController(
        Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
