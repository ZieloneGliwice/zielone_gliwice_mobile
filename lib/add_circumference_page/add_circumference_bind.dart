import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_circumference_page.dart';

class AddCircumferencePageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextEditingController>(() => TextEditingController(), fenix: true);
    Get.lazyPut<AddTreeCircumferenceController>(() => AddTreeCircumferenceController(Get.find()), fenix: true);
  }
}
