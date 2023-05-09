import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../analytics/analytics.dart';
import '../model/session.dart';
import '../model/signed_user.dart';
import '../model/user_data.dart';
import '../my_trees/my_trees_page.dart';
import '../ui/activity_indicator.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import '../utils/session_storage.dart';
import 'social_authentication_provider.dart';


class LogInPage extends GetView<LogInPageController> {
  const LogInPage({super.key});

  static const String path = '/log_in_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(LogInPage.path);
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(child: _logo()),
            Expanded(child: controller.obx((bool? isLoading) {
              if (isLoading ?? false) {
                return const ActivityIndicator();
              } else {
                return _buttons();
              }
            },
              onLoading: const ActivityIndicator(),
            )
            ),
          ],
        ));
  }

  Widget _buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('log_in_using_account'.tr, style: ApplicationTextStyles.placeholderHeaderTextStyle, textAlign: TextAlign.center,),
        const SizedBox(height: 30,),
        SignInButton(
          Buttons.Google,
          onPressed: (){
            controller.googleLogIn();
          },
        ),
        const SizedBox(height: 30,),
        SignInButton(
          Buttons.AppleDark,
          onPressed: (){
            controller.appleLogIn();
          },
        ),
      ],
    );
  }

  Widget _logo() {
    const String assetName = 'assets/images/full_logo.png';
    return const Image(image: AssetImage(assetName));
  }

}

class LogInPageController extends GetxController with StateMixin<bool> {
  LogInPageController(this.socialAuthenticationProvider, this.googleSignIn, this.sessionStorage);

  final GoogleSignIn googleSignIn;
  final SocialAuthenticationProvider socialAuthenticationProvider;
  final SessionStorage sessionStorage;

  RxBool isLoading = false.obs;
  RxBool isAppleAvailable = false.obs;

  @override
  void onInit() {
    super.onInit();

    _loadConfiguration();
  }

  Future<void> _loadConfiguration() async {
    change(null, status: RxStatus.loading());

    isLoading.value = true;
    isAppleAvailable.value = await SignInWithApple.isAvailable();
    isLoading.value = false;

    final SignedUser? user = await sessionStorage.restoreSession();

    if (user != null) {
      Get.offAllNamed(MyTreesPage.path);
    } else {
      change(false, status: RxStatus.success());
    }
  }

  Future<void> googleLogIn() async {
    try {
      change(null, status: RxStatus.loading());
      final GoogleSignInAccount? user = await googleSignIn.signIn();
      final GoogleSignInAuthentication? authentication = await user?.authentication;
      final String? idToken = authentication?.idToken;

      final Session session = await socialAuthenticationProvider.googleAuthenticate(idToken, user?.serverAuthCode);
      await storeSession(session, user?.displayName, user?.photoUrl, user?.email);
      Analytics.loginWithGoogle();
      Get.offAllNamed(MyTreesPage.path);

    } on SocketException catch (_) {
      noInternetConnection();
    } catch (error) {
      failedToLogIn();
    }
  }

  Future<void> appleLogIn() async {
    change(null, status: RxStatus.loading());

    try {
      final AuthorizationCredentialAppleID credential =
      await SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
              clientId: 'pl.zielonegliwice',
              redirectUri: Uri.parse(
                  'https://fa-greengliwice.azurewebsites.net/api/.auth/login/apple/callback'))
      );

      final String? idToken = credential.identityToken;
      final String authCode = credential.authorizationCode;

      final Session session = await socialAuthenticationProvider.appleAuthenticate(idToken, authCode);
      await storeSession(session, credential.givenName, null, credential.email);
      Analytics.loginWithApple();
      Get.offAllNamed(MyTreesPage.path);
    } on SocketException catch (_) {
      noInternetConnection();
    } catch (_) {
      failedToLogIn();
    }
  }

  Future<void> storeSession(Session session, String? userName, String? photoUrl, String? email) async {
    final UserData userData = UserData(userName, photoUrl, email);
    final SignedUser signedUser = SignedUser(session, userData);

    await sessionStorage.storeSession(signedUser);
  }

  void noInternetConnection() {
    Get.defaultDialog(title: 'error'.tr, middleText: 'no_internet_connection'.tr, confirm: PrimaryButton(title: 'ok'.tr, isEnabled: true, onTap: () { Get.back(); },));
    change(false, status: RxStatus.success());
  }

  void failedToLogIn() {
    Get.defaultDialog(title: 'error'.tr, middleText: 'authorization_failed'.tr, confirm: PrimaryButton(title: 'ok'.tr, isEnabled: true, onTap: () { Get.back(); },));
    Analytics.loginFailed();
    change(false, status: RxStatus.success());
  }
}
