import 'package:flutter/material.dart';

class AddTreePage extends StatelessWidget {
  const AddTreePage({super.key});

  static const String path = '/add_tree_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj drzewo'),
      ),
      body: const Center(
        child: Text('Nie masz jeszcze dodanych drzew'),
      ),
    );
  }
}