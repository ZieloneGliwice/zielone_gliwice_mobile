import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../email_create_account/email_create_account_page.dart';
import '../log_in/social_authentication_provider.dart';
import '../model/session.dart';
import '../model/signed_user.dart';
import '../model/user.dart' as app_user;
import '../model/user_data.dart';
import '../my_trees/my_trees_page.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class EmailLogInPage extends GetView<EmailLogInPageController> {
  const EmailLogInPage({super.key});
  static const String path = '/email_log_in_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('log_in'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      prefixIconColor: ApplicationColors.gray,
                    ),
                    textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: ApplicationColors.green)),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      _logo(),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller.emailController,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          floatingLabelStyle:
                              const TextStyle(color: ApplicationColors.green),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ApplicationColors.green),
                          ),
                          label: Text('email_adress'.tr),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          style: const TextStyle(fontSize: 18),
                          obscureText: controller.passwordHidden.value,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                const TextStyle(color: ApplicationColors.green),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ApplicationColors.green),
                            ),
                            label: Text('password'.tr),
                            prefixIcon: const Icon(Icons.fingerprint),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  controller.passwordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ApplicationColors.gray),
                              onPressed: () {
                                controller.passwordHidden.value =
                                    !controller.passwordHidden.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 30),
                          Expanded(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ApplicationColors.gray,
                                  ),
                                  onPressed: () => {
                                    Get.toNamed(EmailCreateAccountPage.path)
                                  },
                                  child: Text(
                                    'create_account'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ApplicationColors.green,
                                  ),
                                  onPressed: () =>
                                      controller.signUserIn(context),
                                  child: Text(
                                    'log_in'.tr,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    const String assetName = 'assets/images/full_logo.png';
    return const Image(image: AssetImage(assetName));
  }
}

class EmailLogInPageController extends GetxController with StateMixin<bool> {
  EmailLogInPageController(
      this.socialAuthenticationProvider, this.sessionStorage);

  final SocialAuthenticationProvider socialAuthenticationProvider;
  final SessionStorage sessionStorage;

  RxBool passwordHidden = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getData();
  }

  // Future<void> getData() async {

  // }
  Future<void> signUserIn(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      final User? user = userCredential.user;
      final AuthCredential? authentication = userCredential.credential;
      final String? idToken = authentication?.accessToken;
      // final String? idToken = authentication?.token.toString();

      final String? userId = user?.uid;
      final app_user.User appUser = app_user.User(id: userId);

      final Session session =
          Session(authenticationToken: idToken, user: appUser);
      // final Session session = await socialAuthenticationProvider
      //     .emailAuthenticate(idToken, idToken);

      await storeSession(session, user?.displayName, null, user?.email);

      Navigator.pop(context);
      Get.offAllNamed(MyTreesPage.path);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      switch (e.code) {
        case 'channel-error':
          showMessage('complete_data'.tr, context);
          break;
        case 'invalid-email':
          showMessage('invalid_email'.tr, context);
          break;
        case 'user-not-found':
          showMessage('account_not_found'.tr, context);
          break;
        case 'wrong-password':
          showMessage('wrong_password'.tr, context);
          break;
        default:
          showMessage(e.code, context);
      }
    }
  }

  Future<void> storeSession(Session session, String? userName, String? photoUrl,
      String? email) async {
    final UserData userData = UserData(userName, photoUrl, email);
    final SignedUser signedUser = SignedUser(session, userData);

    await sessionStorage.storeSession(signedUser);
  }

  showMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ApplicationColors.green,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
