import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static const String path = '/start_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje drzewa'),
      ),
      body: const Center(
        child: Text('Nie masz jeszcze dodanych drzew'),
      ),
    );
  }
}
