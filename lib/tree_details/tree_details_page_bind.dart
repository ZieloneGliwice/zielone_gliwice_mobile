import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/tree_details_provider.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'tree_details_page.dart';

class TreeDetailsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => TreeDetailsProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => TreeDetailsController(Get.find(), Get.find(), Get.find()),
        fenix: true);
  }
}
