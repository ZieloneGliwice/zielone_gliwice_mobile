import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'styles.dart';

class BottomBar extends BottomAppBar {
  BottomBar({super.key, int? activeId})
      : super(
            elevation: 8,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: item(
                      Icons.home, 'start'.tr, activeId == 0, '/my_trees_page'),
                ),
                Expanded(
                  child: item(Icons.add_circle_outline_rounded,
                      'add_tree_title'.tr, activeId == 1, '/next_tree_page'),
                ),
                Expanded(
                  child: item(Icons.star_border_rounded, 'challenges_title'.tr,
                      activeId == 2, '/challengess_page'),
                ),
              ],
            ));
}

SizedBox item(IconData icon, String labelText, bool isOn, String targetPath) {
  return SizedBox(
    child: TextButton.icon(
      onPressed: () => Get.toNamed(targetPath),
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
