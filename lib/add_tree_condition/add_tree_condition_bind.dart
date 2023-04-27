
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/dictionary_data_provider.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'add_tree_condition_page.dart';

class AddTreeConditionBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => DictionaryDataProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => TextEditingController(), fenix: true);
    Get.lazyPut(() => AddTreeConditionPageController(Get.find(), Get.find(), Get.find(), Get.find()), fenix: true);
  }
}
