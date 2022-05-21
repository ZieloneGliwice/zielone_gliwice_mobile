import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/gray_app_bar.dart';
import '../ui/no_data_view.dart';
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
      body: _noData(),
    );
  }

  Widget _noData() {
    return NoDataView(
      icon: Icons.energy_savings_leaf,
      header: 'welcome_name'.trParams({ 'name': 'Aleksander'}),
      title: 'you_dont_have_tree_yet'.tr,
      message: 'add_your_first_tree'.tr,
      buttonTitle: 'add_tree_title'.tr,
      onPressed: () {},
    );
  }
}
