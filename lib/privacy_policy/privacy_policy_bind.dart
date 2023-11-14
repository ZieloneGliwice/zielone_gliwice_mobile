import 'package:get/get.dart';

import 'privacy_policy_page.dart';

class PrivacyPolicyBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyPageController(), fenix: true);
  }
}
