import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class MyTreesPage extends StatelessWidget {
  const MyTreesPage({super.key});

  static const String path = '/my_trees_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('my_trees_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: const Center(
        child: Text('Zielone Gliwice'),
      ),
    );
  }
}