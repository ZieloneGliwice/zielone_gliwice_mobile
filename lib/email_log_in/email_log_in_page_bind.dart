import 'package:get/get.dart';

import '../log_in/social_authentication_provider.dart';
import '../network/api_dio.dart';
import '../utils/session_storage.dart';
import 'email_log_in_page.dart';

class EmailLogInPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => SocialAuthenticationProvider(Get.find()), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => EmailLogInPageController(Get.find(), Get.find()),
        fenix: true);
  }
}
