import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class AddTreePage extends StatelessWidget {
  const AddTreePage({super.key});

  static const String path = '/add_tree_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('add_tree_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: const Center(
        child: Text('Zielone Gliwice'),
      ),
    );
  }
}
