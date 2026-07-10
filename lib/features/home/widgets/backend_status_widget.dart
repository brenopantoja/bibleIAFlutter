import 'package:flutter/material.dart';

class BackendStatusWidget extends StatelessWidget {
  final bool online;
  final String applicationName;
  final String version;

  const BackendStatusWidget({
    super.key,
    required this.online,
    required this.applicationName,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: online ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(applicationName),
                const SizedBox(width: 8),
                Text('v$version'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}