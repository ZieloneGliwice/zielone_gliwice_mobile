import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../env/keys.dart';
import '../network/api_dio.dart';
import '../utils/session_storage.dart';
import 'log_in_page.dart';
import 'social_authentication_provider.dart';

class LogInPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleSignIn(scopes: <String>[
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
        serverClientId: Keys.SERVER_ID_KEY,
    ), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => SocialAuthenticationProvider(Get.find()), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => LogInPageController(Get.find(), Get.find(), Get.find()), fenix: true);
  }
}
