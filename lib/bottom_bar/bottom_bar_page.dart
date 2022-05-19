import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../challenges/challenges_page.dart';
import '../my_trees/my_trees_page.dart';
import '../ui/styles.dart';

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
      )
      ),
    );
  }
}

class BottomBarPageController extends GetxController {
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}