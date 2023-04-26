import 'package:flutter/material.dart';

import 'styles.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: ApplicationColors.green,),);
  }
}
