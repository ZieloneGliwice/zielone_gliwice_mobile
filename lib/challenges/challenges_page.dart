import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../model/errors.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../ui/bottom_bar.dart';
import '../ui/dimen.dart';
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
        bottomNavigationBar: BottomBar(
          activeId: 2,
          photosService: controller.photosService,
        ),
        backgroundColor: ApplicationColors.background,
        body: _body());
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          _textPoints(points: 133),
          _textPosition(position: 2),
          const SizedBox(height: 10),
          Stack(
            children: [
              _image(url: 'assets/images/hulajnoga_test.png'),
              Positioned(
                bottom: 10,
                right: 10,
                child: _buttonPlay(),
              )
            ],
          ),
          _allStats(),
        ],
      ),
    );
  }

  Widget _textPoints({int? points}) {
    return RichText(
      text: TextSpan(
        text: 'challenges_1'.tr,
        style: ApplicationTextStyles.challengesRegularContentTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: points != null ? points.toString() : '0',
            style: ApplicationTextStyles.challengesGreenContentTextStyle,
          ),
          TextSpan(
            text: 'challenges_2'.tr,
            style: ApplicationTextStyles.challengesGreenContentTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _textPosition({int? position}) {
    return RichText(
      text: TextSpan(
        text: 'challenges_3'.tr,
        style: ApplicationTextStyles.challengesRegularContentTextStyle,
        children: <TextSpan>[
          TextSpan(
            text: position != null ? position.toString() : '0',
            style: ApplicationTextStyles.challengesBoldContentTextStyle,
          ),
          TextSpan(
            text: 'challenges_4'.tr,
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
              'play'.tr,
              style: ApplicationTextStyles.challengesButtonContentTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _allStats() {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.only(top: 12, bottom: 30, left: 20, right: 20),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) =>
          _userStats(index + 1, 'Grzegorz Gżegżółka', 145),
      // child: _myTree(trees[index])

      separatorBuilder: (BuildContext context, int index) =>
          const Divider(thickness: 1, color: ApplicationColors.white),
      // itemCount: trees.length
      itemCount: 300,
    ));
  }

  Widget _userStats(int position, String name, int points) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            position.toString(),
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        ),
        const Expanded(
          flex: 4,
          child: SizedBox(
            height: 40,
            child: Icon(
              Icons.account_circle_rounded,
              size: 32,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            '$points pkt',
            textAlign: TextAlign.right,
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        )
      ],
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
