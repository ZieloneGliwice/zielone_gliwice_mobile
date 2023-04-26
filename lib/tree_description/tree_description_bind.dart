import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'tree_description_page.dart';

class TreeDescriptionPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextEditingController>(() => TextEditingController(), fenix: true);
    Get.lazyPut<TreeDescriptionController>(() => TreeDescriptionController(Get.find()), fenix: true);
  }
}
