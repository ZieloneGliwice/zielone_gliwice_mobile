import 'package:get/get.dart';

import 'rules_page.dart';

class RulesBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RulesPageController(), fenix: true);
  }
}
