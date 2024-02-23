import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../about_app/about_app_page.dart';
import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../network/my_leaderboard_entry_delete_provider.dart';
import '../network/my_trees_delete_provider.dart';
import '../personal_info/personal_info_page.dart';
import '../privacy_policy/privacy_policy_page.dart';
import '../rules/rules_page.dart';
import '../ui/activity_indicator.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

import '../utils/session_controller.dart';

class SettingsPage extends GetView<SettingsPageController> {
  const SettingsPage({super.key});
  static const String path = '/settings_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(),
      backgroundColor: ApplicationColors.background,
      body: controller.obx(
        (_) => _body(),
        onLoading: const ActivityIndicator(),
        onError: (String? error) => _errorView(error),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 30,
        elevation: 0,
        color: Colors.transparent,
        child: controller.obx(
          (_) => _appVersion(),
          onLoading: const BottomAppBar(
            color: ApplicationColors.background,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <SliverFillRemaining>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                Obx(
                  () => _userPhoto(),
                ),
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
          border: const Border(
            top: BorderSide(color: ApplicationColors.black),
            left: BorderSide(color: ApplicationColors.black),
            right: BorderSide(color: ApplicationColors.black),
            bottom: BorderSide(color: ApplicationColors.black),
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.contain,
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

  Widget _appVersion() {
    if (controller.version.value != null &&
        controller.version.value.isNotEmpty) {
      return Text(
        'version'.trParams(
            <String, String>{'current_version': controller.version.value}),
        textAlign: TextAlign.center,
        style: ApplicationTextStyles.settingsVersionTextStyle,
      );
    } else {
      return const Text('');
    }
  }

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
          ),
          _line(),
          InkWell(
            onTap: () => showDeleteAccountDialog(),
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
                      child: Text('delete_account'.tr,
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

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(SettingsPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getData);
  }

  Widget _line() {
    return Container(
      height: 0.2,
      color: Colors.black,
    );
  }

  void showDeleteAccountDialog() {
    final BuildContext context = Get.context!;
    final Widget cancelButton = TextButton(
      child: Text(
        'cancel'.tr,
        style: ApplicationTextStyles.settingsAlertCancelTextStyle,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    final Widget continueButton = TextButton(
      child: Text(
        'continue'.tr,
        style: ApplicationTextStyles.settingsAlertNextTextStyle,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        controller.deleteAccount();
      },
    );

    final AlertDialog alert = AlertDialog(
      title: Text(
        'delete_account_dialog_title'.tr,
        textAlign: TextAlign.center,
        style: ApplicationTextStyles.settingsAlertTitleTextStyle,
      ),
      titlePadding: const EdgeInsets.only(top: 18),
      content: Text(
        'delete_account_dialog_content'.tr,
        textAlign: TextAlign.center,
        style: ApplicationTextStyles.settingsAlertContentTextStyle,
      ),
      contentPadding:
          const EdgeInsets.only(top: 6, bottom: 18, left: 6, right: 6),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class SettingsPageController extends SessionController with StateMixin<bool> {
  SettingsPageController(
      this._myTreesDeleteProvider,
      this._myLeaderboardEntryDeleteProvider,
      super.sessionStorage,
      super.photosService);

  final MyTreesDeleteProvider _myTreesDeleteProvider;
  final MyLeaderboardEntryDeleteProvider _myLeaderboardEntryDeleteProvider;

  RxString version = ''.obs;
  RxString photoURL = ''.obs;
  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      await getVersion();
      await loadUser();

      change(true, status: RxStatus.success());
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  Future<void> loadUser() async {
    final SignedUser? signedUser = await sessionStorage.restoreSession();

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
          'subject': 'mail_subject'.tr,
          'body': 'mail_body'.tr,
        },
      ),
    );

    launchUrl(emailUri);
  }

  Future<void> deleteAccount() async {
    await _myTreesDeleteProvider.deleteTrees();

    await _myLeaderboardEntryDeleteProvider.deleteEntry();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    await logout();
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }

  Future<void> getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
  }
}
