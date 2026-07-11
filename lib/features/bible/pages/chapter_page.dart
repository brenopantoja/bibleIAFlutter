import 'package:flutter/material.dart';

class ChapterPage extends StatelessWidget {

  const ChapterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Capítulos'),
      ),

      body: const Center(
        child: Text(
          'Lista de capítulos',
        ),
      ),

    );
  }
}