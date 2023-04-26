import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/my_tree_details_provider.dart';
import '../utils/session_storage.dart';
import 'my_tree_details_page.dart';

class MyTreeDetailsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => MyTreeDetailsProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => MyTreeDetailsController(Get.find(), Get.find()), fenix: true);
  }
}
