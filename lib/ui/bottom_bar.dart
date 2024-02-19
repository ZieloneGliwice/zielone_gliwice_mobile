import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../analytics/analytics.dart';
import '../services/photos_service.dart';
import 'styles.dart';

class BottomBar extends BottomAppBar {
  BottomBar({super.key, int? activeId, required PhotosService photosService})
      : super(
          elevation: 8,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: item(Icons.home, 'start'.tr, activeId == 0,
                    '/my_trees_page', photosService),
              ),
              Expanded(
                child: item(
                    Icons.add_circle_outline_rounded,
                    'add_tree_title'.tr,
                    activeId == 1,
                    '/add_tree_page',
                    photosService),
              ),
              Expanded(
                child: item(Icons.star_border_rounded, 'challenges_title'.tr,
                    activeId == 2, '/challenges_page', photosService),
              ),
            ],
          ),
        );
}

Future<void> addNewTree(PhotosService photosService) async {
  Analytics.buttonPressed('Add tree');
  await photosService.clearCachedPhotos();
  Get.toNamed(AddTreePage.path);
}

SizedBox item(IconData icon, String labelText, bool isOn, String targetPath,
    PhotosService photosService) {
  return SizedBox(
    child: TextButton.icon(
      onPressed: () => {
        if (targetPath == '/add_tree_page')
          addNewTree(photosService)
        else
          Get.toNamed(targetPath)
      },
      icon: Column(
        children: <Widget>[
          Icon(
            icon,
            color: isOn ? ApplicationColors.green : ApplicationColors.gray,
            size: 30,
          ),
          Text(
            labelText,
            style: TextStyle(
                color: isOn ? ApplicationColors.green : ApplicationColors.gray,
                fontWeight: FontWeight.w500,
                fontSize: 13,
                fontFamily: 'Poppins'),
          ),
        ],
      ),
      label: const Text(
        '',
        style: TextStyle(
          color: ApplicationColors.green,
        ),
      ),
    ),
  );
}
