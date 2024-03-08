import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../analytics/analytics.dart';
import '../services/photos_service.dart';
import 'dimen.dart';
import 'styles.dart';

class BottomBar extends BottomNavigationBar {
  BottomBar({super.key, int? activeId, required PhotosService photosService})
      : super(
          elevation: 8,
          iconSize: 32,
          selectedFontSize: 16,
          unselectedFontSize: 14,
          selectedItemColor: ApplicationColors.green,
          currentIndex: activeId!,
          onTap: (int index) {
            switch (index) {
              case 0:
                Get.toNamed('/my_trees_page');
                break;
              case 1:
                addNewTree(photosService);
                break;
              case 2:
                Get.toNamed('/challenges_page');
                break;
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: Dimen.marginTiny),
                child: const Icon(Icons.home),
              ),
              label: 'start'.tr,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: Dimen.marginTiny),
                child: const Icon(Icons.add_circle_outline_rounded),
              ),
              label: 'add_tree_title'.tr,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: Dimen.marginTiny),
                child: const Icon(Icons.star_border_rounded),
              ),
              label: 'challenges_title'.tr,
            ),
          ],
        );
}

Future<void> addNewTree(PhotosService photosService) async {
  Analytics.buttonPressed('Add tree');
  await photosService.clearCachedPhotos();
  Get.toNamed(AddTreePage.path);
}
