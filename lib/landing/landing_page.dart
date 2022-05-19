import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../camera/camera_page.dart';
import '../challenges/challenges_page.dart';
import '../start/start_page.dart';
import '../ui/styles.dart';

class LandingPage extends GetView<LandingPageController> {
  LandingPage({super.key});

  static const String path = '/landing_page';

  final TextStyle unselectedLabelStyle = const TextStyle(
      color: ApplicationColors.gray,
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(color: ApplicationColors.green, fontWeight: FontWeight.w500, fontSize: 12);

  final double iconSize = 25;

  Widget _buildBottomNavigationMenu(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      elevation: 16.0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex.value,
      backgroundColor: const Color(0xFFF9F9F9),
      unselectedItemColor: ApplicationColors.gray,
      selectedItemColor: ApplicationColors.green,
      unselectedLabelStyle: unselectedLabelStyle,
      selectedLabelStyle: selectedLabelStyle,
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
          label: 'Start',
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
          label: 'Wyzwania',
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationMenu(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.toNamed(CameraPage.path),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: const <Widget>[
          StartPage(),
          ChallengesPage(),
        ],
      )
      ),
    );
  }
}

class LandingPageController extends GetxController {
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
