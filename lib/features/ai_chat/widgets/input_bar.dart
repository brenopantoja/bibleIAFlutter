import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSend;

  final bool sending;

  const InputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.sending,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          8,
          12,
          12,
        ),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {

            final hasText =
                value.text.trim().isNotEmpty;

            return Row(

              crossAxisAlignment:
                  CrossAxisAlignment.end,

              children: [

                Expanded(

                  child: TextField(

                    controller: controller,

                    minLines: 1,

                    maxLines: 6,

                    textInputAction:
                        TextInputAction.send,

                    onSubmitted: (_) {

                      if (hasText &&
                          !sending) {
                        onSend();
                      }

                    },

                    decoration:
                        InputDecoration(

                     hintText: BibleProvider.instance.english
                        ? 'Ask me anything...'
                        : 'Pergunte qualquer coisa...',
                        
                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                    ),

                  ),

                ),

                const SizedBox(
                  width: 8,
                ),

                AnimatedContainer(

                  duration:
                      const Duration(
                    milliseconds: 180,
                  ),

                  width: 56,

                  height: 56,

                  decoration: BoxDecoration(

                    color: hasText
                        ? Theme.of(context)
                            .primaryColor
                        : Colors.grey.shade300,

                    shape: BoxShape.circle,

                  ),

                  child: sending

                      ? const Padding(

                          padding:
                              EdgeInsets.all(14),

                          child:
                              CircularProgressIndicator(

                            strokeWidth: 2,

                            color: Colors.white,

                          ),

                        )

                      : IconButton(

                          onPressed:
                              hasText
                                  ? onSend
                                  : null,

                          icon: Icon(

                            hasText
                                ? Icons.send_rounded
                                : Icons.mic,

                            color: hasText
                                ? Colors.white
                                : Colors.black54,

                          ),

                        ),

                ),

              ],

            );

          },

        ),

      ),

    );

  }

}