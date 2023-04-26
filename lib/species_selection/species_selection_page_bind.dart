import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/dictionary_data_provider.dart';
import '../utils/session_storage.dart';
import 'species_selection_page.dart';

class SpeciesSelectionBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => DictionaryDataProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => TextEditingController(), fenix: true);
    Get.lazyPut(() => SpeciesSelectionController(Get.find(), Get.find(), Get.find()), fenix: true);
  }
}
