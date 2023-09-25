import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../about_app/about_app_page.dart';
import '../model/signed_user.dart';
import '../personal_info/personal_info_page.dart';
import '../privacy_policy/privacy_policy_page.dart';
import '../rules/rules_page.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_storage.dart';

class SettingsPage extends GetView<SettingsPageController> {
  const SettingsPage({super.key});
  static const String path = '/settings_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Obx(() => _userPhoto()),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(() => _userName()),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ApplicationColors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: InkWell(
                      onTap: () => Get.toNamed(PersonalInfoPage.path),
                      child: _settingsRow(
                          const Icon(Icons.settings_outlined),
                          Text('personal_info'.tr,
                              style: ApplicationTextStyles.settingsTextStyle)),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  _settingsColumn(),
                ],
              ),
            ),
          ],
        ),
      ),
      //not working
      //   bottomNavigationBar: BottomAppBar(
      //       elevation: 0,
      //       color: Colors.transparent,
      //       child: Obx(() => _appVersion())),
    );
  }

  Text _userName() {
    if (controller.userName.value != null &&
        controller.userName.value.isNotEmpty) {
      return Text(controller.userName.value,
          style: ApplicationTextStyles.settingsNameTextStyle);
    } else {
      return Text('your_account'.tr,
          style: ApplicationTextStyles.settingsNameTextStyle);
    }
  }

  Widget _userPhoto() {
    if (controller.photoURL.value != null &&
        controller.photoURL.value.isNotEmpty) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(controller.photoURL.value),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 100,
        height: 100,
        child: Icon(
          Icons.account_circle_rounded,
          size: 100,
        ),
      );
    }
  }

  //not working
  // Widget _appVersion() {
  //   if (controller.version.value != null &&
  //       controller.version.value.isNotEmpty) {
  //     return Text(
  //       'version'.trParams(
  //           <String, String>{'current_version': controller.version.value}),
  //       textAlign: TextAlign.center,
  //       style: ApplicationTextStyles.settingsVersionTextStyle,
  //     );
  //   } else {
  //     return const Text('');
  //   }
  // }

  Widget _settingsColumn() {
    return Container(
      decoration: BoxDecoration(
        color: ApplicationColors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => Get.toNamed(AboutAppPage.path),
            child: _settingsRow(
                const Icon(
                  Icons.help_outline,
                  color: ApplicationColors.green,
                  size: 24,
                ),
                Text('about_app'.tr,
                    style: ApplicationTextStyles.settingsTextStyle)),
          ),
          _line(),
          InkWell(
            onTap: () => controller.sendFeedback(),
            child: _settingsRow(
                const Icon(
                  Icons.feedback_outlined,
                  color: ApplicationColors.green,
                  size: 24,
                ),
                Text('send_feedback'.tr,
                    style: ApplicationTextStyles.settingsTextStyle)),
          ),
          _line(),
          InkWell(
            onTap: () => controller.rateUs(),
            child: _settingsRow(
                const Icon(
                  Icons.star_outline,
                  color: ApplicationColors.green,
                  size: 24,
                ),
                Text('rate_us'.tr,
                    style: ApplicationTextStyles.settingsTextStyle)),
          ),
          _line(),
          InkWell(
            onTap: () => Get.toNamed(PrivacyPolicyPage.path),
            child: _settingsRow(
                const Icon(
                  Icons.folder_outlined,
                  color: ApplicationColors.green,
                  size: 24,
                ),
                Text('privacy_policy'.tr,
                    style: ApplicationTextStyles.settingsTextStyle)),
          ),
          _line(),
          InkWell(
            onTap: () => Get.toNamed(RulesPage.path),
            child: _settingsRow(
                const Icon(
                  Icons.folder_outlined,
                  color: ApplicationColors.green,
                  size: 24,
                ),
                Text('rules'.tr,
                    style: ApplicationTextStyles.settingsTextStyle)),
          ),
          _line(),
          InkWell(
            onTap: () => controller.logout(),
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text('logout'.tr,
                          style: ApplicationTextStyles.settingsLogoutTextStyle),
                    ),
                    const Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _settingsRow(Icon icon, Text text, {Color? color}) {
    return Container(
      height: 50,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            icon,
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: text,
            ),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.2,
    color: Colors.black,
  );
}

class SettingsPageController extends GetxController {
  SettingsPageController(this._sessionStorage);

  final SessionStorage _sessionStorage;

  // RxString version = ''.obs;
  RxString photoURL = ''.obs;
  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void logout() {
    print('xd :) super Ci idzie Filip');
  }

  Future<void> getData() async {
    await loadUser();
    // await getVersion();
  }

  Future<void> loadUser() async {
    final SignedUser? signedUser = await _sessionStorage.restoreSession();

    userName.value = signedUser?.details.name ?? '';
    photoURL.value = signedUser?.details.photoUrl ?? '';
  }

  void rateUs() {
    if (Platform.isAndroid || Platform.isIOS) {
      final String appId = Platform.isAndroid
          ? 'pl.zielonegliwice.zielone_gliwice_mobile'
          : 'pl.zielonegliwice';
      final Uri url = Uri.parse(
        Platform.isAndroid
            ? 'market://details?id=$appId'
            : 'https://apps.apple.com/app/id$appId',
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void sendFeedback() {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    const String mail = 'kontakt@media30.pl';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: mail,
      query: encodeQueryParameters(
        <String, String>{
          'subject': 'Zielone Gliwice feedback',
          'body': 'mail_body'.tr,
        },
      ),
    );

    launchUrl(emailUri);
  }

  // to do, appversion on the bottom
  // Future<void> getVersion() async {
  //   final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   version.value = packageInfo.version;
  // }
}
