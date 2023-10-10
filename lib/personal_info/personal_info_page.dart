import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../schools_selection/schools_selection_page.dart';
import '../ui/activity_indicator.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';

class PersonalInfoPage extends GetView<PersonalInfoPageController> {
  const PersonalInfoPage({super.key});
  static const String path = '/personal_info_page';

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
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.settings_outlined),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text('personal_info'.tr,
                                    style: ApplicationTextStyles
                                        .settingsTextStyle),
                              ),
                            ],
                          ), //
                        ),
                      ),
                      _line(),
                      InkWell(
                        onTap: controller.selectSchools,
                        child: SizedBox(
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                    child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: ApplicationColors.inputBackground,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Obx(() => _schoolName()),
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _schoolName() {
    if (controller.school.value != null &&
        controller.school.value.isNotEmpty &&
        controller.school.value != '') {
      return Text(controller.school.value,
          textAlign: TextAlign.center,
          style: ApplicationTextStyles.personalInfoFieldsTextStyle);
    } else {
      return Text('choose_school'.tr,
          textAlign: TextAlign.center,
          style: ApplicationTextStyles.personalInfoFieldsTextStyle);
    }
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

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(PersonalInfoPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getData);
  }

  Widget _line() {
    return Container(
      height: 0.2,
      color: Colors.black,
    );
  }
}

class PersonalInfoPageController extends SessionController
    with StateMixin<bool> {
  PersonalInfoPageController(super.sessionStorage, super.photosService);
  SharedPreferences? prefs;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;
  RxString school = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      await loadUser();
      await loadSchool();
      change(true, status: RxStatus.success());
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  Future<void> loadSchool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String schoolName = prefs.getString('school') ?? '';
    school.value = schoolName;
  }

  Future<void> loadUser() async {
    final SignedUser? signedUser = await sessionStorage.restoreSession();

    userName.value = signedUser?.details.name ?? '';
    photoURL.value = signedUser?.details.photoUrl ?? '';
  }

  Future<void> selectSchools() async {
    school.value = await Get.toNamed(SchoolsSelectionPage.path) as String;
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
