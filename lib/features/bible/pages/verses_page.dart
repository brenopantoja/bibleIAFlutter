import 'package:flutter/material.dart';

class VersesPage extends StatelessWidget {

  const VersesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Versículos'),
      ),

      body: const Center(
        child: Text(
          'Lista de versículos',
        ),
      ),

    );
  }
}