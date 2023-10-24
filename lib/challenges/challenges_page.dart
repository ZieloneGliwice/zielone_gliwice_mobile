import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../model/errors.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../ui/bottom_bar.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../ui/white_app_bar.dart';
import '../utils/session_controller.dart';

class ChallengesPage extends GetView<ChallengesPageController> {
  const ChallengesPage({super.key});

  static const String path = '/challengess_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WhiteAppBar(
          title: Text('challenges_title'.tr),
          photoURL: controller.photoURL,
        ),
        bottomNavigationBar: BottomBar(activeId: 2),
        backgroundColor: ApplicationColors.background,
        body: _body());
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _textPoints(points: 133),
                  _textPosition(position: 2),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      _image(url: 'assets/images/hulajnoga_test.png'),
                      Positioned(
                        child: _buttonPlay(),
                        bottom: 10,
                        right: 10,
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _textPoints({int? points}) {
    return RichText(
      text: TextSpan(
        text: 'Masz '.tr,
        style: ApplicationTextStyles.challengesRegularContentTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: points != null ? points.toString() : '0',
            style: ApplicationTextStyles.challengesGreenContentTextStyle,
          ),
          TextSpan(
            text: ' punkty.'.tr,
            style: ApplicationTextStyles.challengesGreenContentTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _textPosition({int? position}) {
    return RichText(
      text: TextSpan(
        text: 'Znajdujesz się na '.tr,
        style: ApplicationTextStyles.challengesRegularContentTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: position != null ? position.toString() : '0',
            style: ApplicationTextStyles.challengesBoldContentTextStyle,
          ),
          TextSpan(
            text: ' miejscu w rankingu.'.tr,
            style: ApplicationTextStyles.challengesBoldContentTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _image({String? url}) {
    const String baseAssetName = 'assets/images/full_logo.png';

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        child: url != null
            ? Image(
                image: AssetImage(url),
                fit: BoxFit.fitWidth,
              )
            : const Image(
                image: AssetImage(baseAssetName),
                fit: BoxFit.fitWidth,
              ),
      ),
    );
  }

  Widget _buttonPlay() {
    return InkWell(
      onTap: () => Get.toNamed(AddTreePage.path),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 128,
          height: 50,
          color: ApplicationColors.green,
          child: Center(
            child: Text(
              'Graj!'.tr,
              style: ApplicationTextStyles.challengesButtonContentTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class ChallengesPageController extends SessionController with StateMixin<bool> {
  ChallengesPageController(super.sessionStorage, super.photosService);

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

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
