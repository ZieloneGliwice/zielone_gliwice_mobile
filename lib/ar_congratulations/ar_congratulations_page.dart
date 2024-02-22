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
import 'increment_points_request.dart';

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
        (_) => controller.hasEntry.value ? _bodyAddPoints() : _bodyNewEntry(),
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

  Widget _bodyAddPoints() {
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

  Widget _bodyNewEntry() {
    Analytics.visitedScreen(ArCongratulationsPage.path);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: double.infinity),
            const SizedBox(height: 40),
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
              'added_first_bird'.tr,
              textAlign: TextAlign.center,
              style:
                  ApplicationTextStyles.arCongratulationsDescriptionTextStyle,
            ),
            Text(
              'choose_name'.tr,
              textAlign: TextAlign.center,
              style:
                  ApplicationTextStyles.arCongratulationsDescriptionTextStyle,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                maxLength: 30,
                controller: controller.nameController,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  floatingLabelStyle:
                      const TextStyle(color: ApplicationColors.green),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: ApplicationColors.green),
                  ),
                  label: Text('scoreboard_name'.tr),
                ),
                onChanged: (String text) {
                  controller.checkNameSize(text);
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: controller.hasMinimalSize.value
                    ? () {
                        controller.addNewEntry();
                        Get.offAllNamed(ChallengesPage.path);
                      }
                    : null,
                style: GreenOvalButtonStyle(
                    isEnabled: controller.hasMinimalSize.value),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'save_score'.tr,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ArCongratulationsController extends SessionController
    with StateMixin<bool> {
  ArCongratulationsController(this.newEntryRequest, this.incrementPointsRequest,
      super.sessionStorage, super.photosService);
  NewEntryRequest newEntryRequest;
  IncrementPointsRequest incrementPointsRequest;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;
  RxBool popupDialogOn = false.obs;

  dynamic args = Get.arguments;
  RxInt pointsAmount = 3.obs;
  RxBool hasEntry = false.obs;

  final int nameMinimalSize = 3;
  RxBool hasMinimalSize = true.obs;

  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getData();

    if (hasEntry.value) {
      addPoints();
    }
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

    checkNameSize(userName.value);
  }

  void checkNameSize(String newName) {
    nameController.text = newName;
    hasMinimalSize.value = nameController.text.trim().length >= nameMinimalSize;
  }

  Future<void> addPoints() async {
    try {
      await incrementPointsRequest.incrementPoints(pointsAmount.value);
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  Future<void> addNewEntry() async {
    final NewEntry newEntry = NewEntry(
      userName: nameController.text,
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
