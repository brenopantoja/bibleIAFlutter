import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  final bool visible;

  final String message;

  const TypingIndicator({
    super.key,
    required this.visible,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
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
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue.shade100,
            child: const Icon(
              Icons.auto_awesome,
              size: 16,
              color: Colors.blue,
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}