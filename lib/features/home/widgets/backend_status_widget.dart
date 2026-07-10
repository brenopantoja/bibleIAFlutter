import 'package:flutter/material.dart';

class BackendStatusWidget extends StatelessWidget {
  final bool online;

  const BackendStatusWidget({
    super.key,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.circle,
            size: 12,
            color: online
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            online
                ? 'Backend Online'
                : 'Backend Offline',
          ),
        ],
      ),
    );
  }
}