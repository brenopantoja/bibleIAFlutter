import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onSend;

  final bool sending;

  final String hintText;

  const InputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.sending,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          12,
          8,
          12,
          12,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Expanded(
              child:
                  ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (
                  context,
                  value,
                  _,
                ) {
                  final hasText =
                      value.text.trim().isNotEmpty;

                  return TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 6,
                    keyboardType:
                        TextInputType.multiline,
                    textCapitalization:
                        TextCapitalization.sentences,
                    textInputAction:
                        TextInputAction.send,
                    enabled: !sending,

                    onSubmitted: (_) {
                      if (hasText) {
                        onSend();
                      }
                    },

                    decoration: InputDecoration(
                      hintText: hintText,

                      filled: true,

                      fillColor:
                          Colors.grey.shade100,

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),
                        borderSide:
                            BorderSide.none,
                      ),

                      enabledBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),
                        borderSide:
                            BorderSide.none,
                      ),

                      focusedBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          28,
                        ),
                        borderSide:
                            BorderSide(
                          color:
                              Theme.of(context)
                                  .primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (
                context,
                value,
                _,
              ) {
                final hasText =
                    value.text.trim().isNotEmpty;

                return AnimatedContainer(
                  duration: const Duration(
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
                              EdgeInsets.all(16),
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )

                      : IconButton(
                          splashRadius: 26,

                          icon: Icon(
                            hasText
                                ? Icons.send_rounded
                                : Icons.mic,

                            color: hasText
                                ? Colors.white
                                : Colors.black54,
                          ),

                          onPressed:
                              hasText
                                  ? onSend
                                  : null,
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