import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../analytics/analytics.dart';
import '../ar_game/ar_game_page.dart';
import '../model/challenges_entry.dart';
import '../model/entries.dart';
import '../model/entry.dart';
import '../model/errors.dart';
import '../model/signed_user.dart';
import '../network/api_dio.dart';
import '../network/leaderboard_entries_provider.dart';
import '../network/my_leaderboard_entry_provider.dart';
import '../ui/activity_indicator.dart';
import '../ui/bottom_bar.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/styles.dart';
import '../ui/white_app_bar.dart';
import '../utils/session_controller.dart';

class ChallengesPage extends GetView<ChallengesPageController> {
  const ChallengesPage({super.key});

  static const String path = '/challenges_page';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          _textPoints(points: controller.userPoints.value),
          _textPosition(position: controller.userPosition.value),
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

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(ChallengesPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getData);
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
      onTap: () => Get.toNamed(ArGamePage.path),
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
      child: ScrollablePositionedList.separated(
        initialScrollIndex: controller.userPosition.value < 5
            ? 0
            : controller.userPosition.value - 1,
        initialAlignment: controller.userPosition.value < 5 ? 0 : 0.5,
        padding:
            const EdgeInsets.only(top: 12, bottom: 30, left: 20, right: 20),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            _userStats(controller.leaderBoard[index]),
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(thickness: 1, color: ApplicationColors.white),
        itemCount: controller.leaderBoard.length,
      ),
    );
  }

  Widget _userStats(ChallengesEntry entry) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            entry.position.toString(),
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        ),
        // const Expanded(
        //   flex: 4,
        //   child: SizedBox(
        //     height: 40,
        //     child: Icon(
        //       Icons.account_circle_rounded,
        //       size: 32,
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 7,
          child: Text(
            entry.name,
            textAlign: TextAlign.left,
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            '${entry.points} pkt',
            textAlign: TextAlign.right,
            style: ApplicationTextStyles.challengesLeaderboardTextStyle,
          ),
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}

class ChallengesPageController extends SessionController with StateMixin<bool> {
  ChallengesPageController(this._allEntriesProvider, this._myEntryProvider,
      super.sessionStorage, super.photosService);

  final EntriesProvider _allEntriesProvider;
  final MyEntryProvider _myEntryProvider;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;

  RxList<ChallengesEntry> leaderBoard = <ChallengesEntry>[].obs;
  RxInt userPosition = 0.obs;
  RxInt userPoints = 0.obs;

  late ItemScrollController itemScrollController;
  late ScrollOffsetController scrollOffsetController;
  late ItemPositionsListener itemPositionsListener;
  late ScrollOffsetListener scrollOffsetListener;

  late Entries allEntries;
  late Entries myEntries;

  RxBool hasEntry = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      await loadUser();
      await loadLeaderBoard();
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

  Future<void> loadLeaderBoard() async {
    await loadAllEntries();
    await loadMyEntry();
  }

  Future<void> loadAllEntries() async {
    allEntries = await _allEntriesProvider.getEntries();

    //sort entries
    allEntries.entries!
        .sort((Entry a, Entry b) => b.points!.compareTo(a.points!));

    for (int i = 0; i < allEntries.entries!.length; i++) {
      final Entry currentEntry = allEntries.entries![i];

      leaderBoard.add(
        ChallengesEntry(i + 1, currentEntry.userName ?? 'Jan Nowak',
            currentEntry.points ?? 0),
      );
    }
  }

  Future<void> loadMyEntry() async {
    myEntries = await _myEntryProvider.getEntries();

    if (myEntries.entries!.isEmpty) {
      return;
    }

    hasEntry.value = true;

    final Entry myEntry = allEntries.entries![0];

    userPoints.value = myEntry.points!;

    for (int i = 0; i < allEntries.entries!.length; i++) {
      final Entry currentEntry = allEntries.entries![i];
      if (myEntry.userName == currentEntry.userName &&
          myEntry.points == currentEntry.points) {
        userPosition.value = i + 1;
      }
    }
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
