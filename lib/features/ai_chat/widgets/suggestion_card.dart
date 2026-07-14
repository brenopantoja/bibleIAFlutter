import 'package:biblia_ia/core/localization/app_strings.dart';
import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final VoidCallback onTap;

  const SuggestionCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppStrings.askAI,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text("• ${AppStrings.suggestion1}"),
              const SizedBox(height: 8),
              Text("• ${AppStrings.suggestion2}"),
              const SizedBox(height: 8),
              Text("• ${AppStrings.suggestion3}"),
              const SizedBox(height: 8),
              Text("• ${AppStrings.suggestion4}"),
            ],
          ),
        ),
      ),
    );
  }
}