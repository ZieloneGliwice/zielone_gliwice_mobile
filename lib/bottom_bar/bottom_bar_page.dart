import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../challenges/challenges_page.dart';
import '../log_in/log_in_page.dart';
import '../model/signed_user.dart';
import '../my_trees/my_trees_page.dart';
import '../ui/styles.dart';
import '../utils/session_storage.dart';

class BottomBarPage extends GetView<BottomBarPageController> {
  const BottomBarPage({super.key, this.iconSize = 25});

  static const String path = '/bottom_page';

  final double iconSize;

  Widget _buildBottomNavigationMenu(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      elevation: 10.0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex.value,
      backgroundColor: ApplicationColors.background,
      unselectedItemColor: ApplicationColors.gray,
      selectedItemColor: ApplicationColors.green,
      unselectedLabelStyle: ApplicationTextStyles.unselectedLabelStyle,
      selectedLabelStyle: ApplicationTextStyles.selectedLabelStyle,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: iconSize,
          ),
          activeIcon: Icon(
            Icons.home_filled,
            size: iconSize,
          ),
          label: 'my_trees_title'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline,
            size: iconSize,
          ),
          activeIcon: Icon(
            Icons.add_circle_outlined,
            size: iconSize,
          ),
          label: 'add_tree_title'.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.star_border,
            size: iconSize,
          ),
          activeIcon: Icon(
            Icons.star,
            size: iconSize,
          ),
          label: 'challenges_title'.tr,
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationMenu(context),
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: const <Widget>[
          MyTreesPage(),
          AddTreePage(),
          ChallengesPage(),
        ],
      ),
      ),
    );
  }
}

class BottomBarPageController extends GetxController {
  BottomBarPageController(this.sessionStorage);

  RxInt tabIndex = 0.obs;
  RxString userName = ''.obs;
  RxString photoUrl = ''.obs;
  RxString title = ''.obs;

  final List<String> titles = <String>['my_trees_title'.tr, '', 'challenges_title'.tr];

  final SessionStorage sessionStorage;

  SignedUser? signedUser;

  @override
  void onInit() {
    super.onInit();
    title.value = titles[0];
    readUser();
  }

  Future<void> readUser() async {
    final SignedUser? storedUser = await sessionStorage.restoreSession();

    if (storedUser != null) {
      signedUser = storedUser;
      userName.value = signedUser?.details.name ?? '';
      photoUrl.value = signedUser?.details.photoUrl ?? '';
    } else {
      Get.offAllNamed(LogInPage.path);
    }
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    title.value = titles[index];
  }
}
