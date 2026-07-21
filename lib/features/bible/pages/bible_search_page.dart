import 'package:flutter/material.dart';

class BibleSearchPage extends StatefulWidget {
  const BibleSearchPage({super.key});

  @override
  State<BibleSearchPage> createState() =>
      _BibleSearchPageState();
}

class _BibleSearchPageState
    extends State<BibleSearchPage> {

  final controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesquisar Bíblia',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Digite uma palavra..Oi.',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            const Expanded(
              child: Center(
                child: Text(
                  'Nenhum resultado.',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}