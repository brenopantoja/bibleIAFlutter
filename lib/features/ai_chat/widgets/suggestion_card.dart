import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

class SuggestionCard extends StatelessWidget {
  final ValueChanged<String> onTap;

  const SuggestionCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final english =
        BibleProvider.instance.english;

    final suggestions = english
        ? <String>[
            'Who was Jesus?',
            'Explain John 3:16.',
            'Show verses about faith.',
            'Summarize Genesis.',
          ]
        : <String>[
            'Quem foi Jesus?',
            'Explique João 3:16.',
            'Mostre versículos sobre fé.',
            'Resuma Gênesis.',
          ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          18,
        ),
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  english
                      ? 'Ask Bible IA'
                      : 'Pergunte à Bible IA',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            ...suggestions.map(
              (question) {
                return Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                    onTap: () {
                      onTap(question);
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(
                        14,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors
                            .grey.shade100,
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.chat_bubble_outline,
                            size: 18,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              question,
                              style:
                                  const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}