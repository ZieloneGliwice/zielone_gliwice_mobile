import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  static const String path = '/challengess_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('challenges_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: const Center(
        child: Text('Zielone Gliwice'),
      ),
    );
  }
}
