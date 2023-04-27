
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../model/errors.dart';
import '../model/my_tree.dart';
import '../model/my_trees.dart';
import '../model/signed_user.dart';
import '../my_tree_details/my_tree_details_page.dart';
import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/date.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/no_data_view.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class MyTreesPage extends GetView<MyTreesController> {
  const MyTreesPage({super.key});

  static const String path = '/my_trees_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('my_trees_title'.tr),
        photoURL: controller.photoURL.value,
      ),
      backgroundColor: ApplicationColors.background,
      body: controller.obx((MyTrees? myTrees) {
        if (myTrees?.trees?.isNotEmpty ?? false) {
          return _myTrees(myTrees!.trees!);
        } else {
          return _noData();
        }
      },
          onLoading: const ActivityIndicator(),
          onError: (String? error) => _errorView(error),
          onEmpty: _noData()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.green,
        foregroundColor: ApplicationColors.white,
        onPressed: controller.addNewTree,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _errorView(String? error) {
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.getTrees);
  }

  Widget _noData() {
    return NoDataView(
      icon: Icons.energy_savings_leaf,
      header: 'welcome_name'
          .trParams(<String, String>{'name': controller.userName.value}),
      title: 'you_dont_have_tree_yet'.tr,
      message: 'add_your_first_tree'.tr,
      buttonTitle: 'add_tree_title'.tr,
      onPressed: controller.addNewTree,
    );
  }

  Widget _myTrees(List<MyTree> trees) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              InkWell(onTap: () {
                final MyTree myTree = trees[index];
                controller.viewDetails(myTree);
              }, child: _myTree(trees[index])),
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
                  Date(dateString:  tree.formattedTimeStamp())
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: ApplicationColors.gray)
            ],
          )),
    );
  }
}

class MyTreesController extends SessionController with StateMixin<MyTrees> {
  MyTreesController(this._myTreesProvider, SessionStorage sessionStorage, PhotosService photosService) : super(sessionStorage, photosService);
  final MyTreesProvider _myTreesProvider;

  RxString photoURL = ''.obs;
  RxString userName = ''.obs;

  MyTrees? myTrees;

  @override
  void onInit() {
    super.onInit();
    loadUser();
    getTrees();
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
    await photosService.clearCachedPhotos();
    Get.toNamed(AddTreePage.path);
  }

  Future<void> loadUser() async {
    final SignedUser? signedUser = await sessionStorage.restoreSession();

    userName.value = signedUser?.details.name ?? '';
    photoURL.value = signedUser?.details.photoUrl ?? '';
  }

  void viewDetails(MyTree myTree) {
    Get.toNamed(MyTreeDetailsPage.path, arguments: myTree);
  }
}
