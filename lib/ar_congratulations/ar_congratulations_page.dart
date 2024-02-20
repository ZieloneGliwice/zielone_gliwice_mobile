import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../analytics/analytics.dart';
import '../ar_congratulations/new_entry_request.dart';
import '../challenges/challenges_page.dart';
import '../model/errors.dart';
import '../model/new_entry.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../ui/activity_indicator.dart';
import '../ui/bottom_bar.dart';
import '../ui/error_view.dart';
import '../ui/styles.dart';
import '../ui/white_app_bar.dart';
import '../utils/session_controller.dart';

class ArCongratulationsPage extends GetView<ArCongratulationsController> {
  const ArCongratulationsPage({super.key});

  static const String path = '/ar_congratulations_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(ArCongratulationsPage.path);
    return Scaffold(
      appBar: WhiteAppBar(
        title: Text('ar_congratulations_title'.tr),
        photoURL: controller.photoURL,
      ),
      bottomNavigationBar: BottomBar(
        activeId: 2,
        photosService: controller.photosService,
      ),
      backgroundColor: ApplicationColors.background,
      body: controller.obx(
        (_) => _body(),
        onLoading: const ActivityIndicator(),
        onError: (String? error) => _errorView(error),
      ),
    );
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(ArCongratulationsPage.path);
    final ZGError zgError = ZGError.from(error);
    return ErrorView.from(zgError, controller.getData);
  }

  Widget _body() {
    Analytics.visitedScreen(ArCongratulationsPage.path);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity),
            const SizedBox(height: 60),
            const Image(
              image: AssetImage('assets/images/bird1.png'),
            ),
            const SizedBox(height: 30),
            Text(
              'bravo_name'.trParams(<String, String>{
                'name': controller.userName.value.split(' ').first
              }),
              textAlign: TextAlign.center,
              style: ApplicationTextStyles.arCongratulationsBravoTextStyle,
            ),
            const SizedBox(height: 30),
            Text(
              'added_bird'.tr,
              textAlign: TextAlign.center,
              style:
                  ApplicationTextStyles.arCongratulationsDescriptionTextStyle,
            ),
            Obx(
              () => Text.rich(
                TextSpan(
                  style: ApplicationTextStyles.descriptionTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'you_get'.tr,
                        style: ApplicationTextStyles
                            .arCongratulationsDescriptionTextStyle),
                    TextSpan(
                        text: controller.pointsAmount.toString() + 'points'.tr,
                        style: ApplicationTextStyles
                            .arCongratulationsBoldDescriptionTextStyle),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(ChallengesPage.path);
              },
              style: GreenOvalButtonStyle(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'check_score'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArCongratulationsController extends SessionController
    with StateMixin<bool> {
  ArCongratulationsController(
      this.newEntryRequest, super.sessionStorage, super.photosService);
  NewEntryRequest newEntryRequest;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;
  RxBool popupDialogOn = false.obs;

  dynamic args = Get.arguments;
  RxInt pointsAmount = 3.obs;
  RxBool hasEntry = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    addPoints();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());
    try {
      pointsAmount.value = args['points'] as int;
      hasEntry.value = args['hasEntry'] as bool;
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

  Future<void> addPoints() async {
    //to do pytanie o nazwę
    if (hasEntry.value) {
      //add points
      return;
    }

    //add new entry
    final NewEntry newEntry = NewEntry(
      userName: 'Bakłażan',
      points: pointsAmount.value,
    );

    try {
      await newEntryRequest.createEntry(newEntry);
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
