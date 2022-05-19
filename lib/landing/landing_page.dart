import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../camera/camera_page.dart';
import '../challenges/challenges_page.dart';
import '../start/start_page.dart';

class LandingPage extends GetView<LandingPageController> {
  LandingPage({super.key});

  static const String path = '/landing_page';

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.green.shade200,
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(color: Color(0xFF95C122), fontWeight: FontWeight.w500, fontSize: 12);

  Widget _buildBottomNavigationMenu(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: controller.changeTabIndex,
      currentIndex: controller.tabIndex.value,
      backgroundColor: Colors.green,
      unselectedItemColor: Colors.green.shade200,
      selectedItemColor: Colors.white,
      unselectedLabelStyle: unselectedLabelStyle,
      selectedLabelStyle: selectedLabelStyle,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Container(
            child: const Icon(
              Icons.home_outlined,
              size: 20.0,
            ),
          ),
          label: 'Start',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: const Icon(
              Icons.add_circle_outline,
              size: 35.0,
            ),
          ),
          label: 'Dodaj drzewo',
        ),
        BottomNavigationBarItem(
          icon: Container(
            child: const Icon(
              Icons.star,
              size: 20.0,
            ),
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
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: const <Widget>[
          StartPage(),
          CameraPage(),
          ChallengesPage(),
        ],
      )),
    );
  }
}

class LandingPageController extends GetxController {
  RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
