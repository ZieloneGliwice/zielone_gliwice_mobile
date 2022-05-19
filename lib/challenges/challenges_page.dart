import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  static const String path = '/challenges_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wyzwania'),
      ),
      body: const Center(
        child: Text('Nie masz jeszcze wyzwań'),
      ),
    );
  }
}