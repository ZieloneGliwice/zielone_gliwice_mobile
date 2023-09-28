import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../add_tree/add_tree_page.dart';
import '../analytics/analytics.dart';
import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/my_trees.dart';
import '../model/signed_user.dart';
import '../my_tree_details/my_tree_details_page.dart';
import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../schools_selection/schools_selection_page.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/date.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/no_data_view.dart';
import '../ui/styles.dart';
import '../ui/white_app_bar.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class MyTreesPage extends GetView<MyTreesController> {
  const MyTreesPage({super.key});

  static const String path = '/my_trees_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(MyTreesPage.path);
    return Obx(
      () => Scaffold(
        appBar: controller.popupDialogOn.value
            ? popupWhiteAppBar()
            : WhiteAppBar(
                title: Text('my_trees_title'.tr),
                photoURL: controller.photoURL,
              ),
        backgroundColor: ApplicationColors.background,
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Stack(
            children: [
              controller.obx(
                (MyTrees? myTrees) {
                  if (myTrees?.trees?.isNotEmpty ?? false) {
                    return Stack(
                      children: [
                        _myTrees(myTrees!.trees!),
                        Obx(() => _popupDialog())
                      ],
                    );
                  } else {
                    return Stack(
                      children: [_noData(), Obx(() => _popupDialog())],
                    );
                  }
                },
                onLoading: const ActivityIndicator(),
                onError: (String? error) => _errorView(error),
                onEmpty: Stack(
                  children: [_noData(), Obx(() => _popupDialog())],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: controller.popupDialogOn.value
            ? floatingActionButtonHidden()
            : FloatingActionButton(
                backgroundColor: ApplicationColors.green,
                foregroundColor: ApplicationColors.white,
                onPressed: controller.popupDialogOn.value
                    ? () {}
                    : controller.addNewTree,
                child: const Icon(Icons.add),
              ),
      ),
    );
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(MyTreesPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getTrees);
  }

  Widget _noData() {
    Analytics.visitedNoDataScreen(MyTreesPage.path);
    return Obx(
      () => NoDataView(
        icon: Icons.energy_savings_leaf,
        header: 'welcome_name'
            .trParams(<String, String>{'name': controller.userName.value}),
        title: 'you_dont_have_tree_yet'.tr,
        message: 'add_your_first_tree'.tr,
        buttonTitle: 'add_tree_title'.tr,
        onPressed: controller.addNewTree,
      ),
    );
  }

  Widget _myTrees(List<MyTree> trees) {
    Analytics.visitedScreen(MyTreesPage.path);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: controller.popupDialogOn.value
                  ? () {}
                  : () {
                      final MyTree myTree = trees[index];
                      controller.viewDetails(myTree);
                    },
              child: _myTree(trees[index])),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
                height: 5,
              ),
          itemCount: trees.length),
    );
  }

  Widget _myTree(MyTree tree) {
    return Container(
      decoration: const BoxDecoration(
        color: ApplicationColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: ApplicationColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Image.network(
                    tree.treeThumbnailUrl() ?? '',
                    width: 62,
                    height: 62,
                  )),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tree.species?.capitalize ?? '',
                    style: ApplicationTextStyles.bodyTextStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Date(dateString: tree.formattedTimeStamp())
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: ApplicationColors.gray),
            ],
          )),
    );
  }

  Widget _popupDialog() {
    if (controller.popupDialogOn.value) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: ApplicationColors.black, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          backgroundColor: ApplicationColors.lightGray,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          title: Text(
            'popup_title'.tr,
            textAlign: TextAlign.center,
            style: ApplicationTextStyles.popupDialogTitleTextStyle,
          ),
          content: Text(
            'popup_content'.tr,
            textAlign: TextAlign.center,
            style: ApplicationTextStyles.popupDialogContentTextStyle,
          ),
          actions: [
            TextButton(
              onPressed: () => controller.popupSkip(),
              child: Text(
                'popup_skip'.tr,
                textAlign: TextAlign.center,
                style: ApplicationTextStyles.popupDialogActionTextStyle,
              ),
            ),
            TextButton(
              onPressed: () => controller.popupChooseSchool(),
              child: Text(
                'popup_choose_school'.tr,
                style: ApplicationTextStyles.popupDialogActionTextStyle,
              ),
            )
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  AppBar popupWhiteAppBar() {
    return AppBar(
      backgroundColor: ApplicationColors.background,
      elevation: 0,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButtonHidden() {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      onPressed: () {},
    );
  }
}

class MyTreesController extends SessionController with StateMixin<MyTrees> {
  MyTreesController(this._myTreesProvider, SessionStorage sessionStorage,
      PhotosService photosService)
      : super(sessionStorage, photosService);
  final MyTreesProvider _myTreesProvider;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;
  RxBool popupDialogOn = true.obs;

  MyTrees? myTrees;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await loadUser();
    await checkPopup();
    await getTrees();
  }

  Future<void> getTrees() async {
    change(null, status: RxStatus.loading());

    try {
      myTrees = await _myTreesProvider.getTrees();

      if (myTrees?.trees?.isNotEmpty ?? false) {
        change(myTrees, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void handleError(ZGError error) {
    if (myTrees?.trees?.isNotEmpty ?? false) {
      change(myTrees, status: RxStatus.success());
      Get.defaultDialog(title: error.title, middleText: error.message);
    } else {
      change(null, status: RxStatus.error(error.identifier));
    }
  }

  Future<void> addNewTree() async {
    Analytics.buttonPressed('Add tree');
    await photosService.clearCachedPhotos();
    Get.toNamed(AddTreePage.path);
  }

  Future<void> loadUser() async {
    final SignedUser? signedUser = await sessionStorage.restoreSession();

    userName.value = signedUser?.details.name ?? '';
    photoURL.value = signedUser?.details.photoUrl ?? '';
  }

  void viewDetails(MyTree myTree) {
    Analytics.buttonPressed('Tree details');
    Get.toNamed(MyTreeDetailsPage.path, arguments: myTree);
  }

  Future<void> checkPopup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    popupDialogOn.value = prefs.getBool('showPopup') ?? true;
  }

  Future<void> popupChooseSchool() async {
    popupDialogOn.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showPopup', false);

    Get.toNamed(SchoolsSelectionPage.path);
  }

  Future<void> popupSkip() async {
    popupDialogOn.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showPopup', false);
  }
}
