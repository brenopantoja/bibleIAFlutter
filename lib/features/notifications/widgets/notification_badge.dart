import 'package:flutter/material.dart';

import '../controller/notification_controller.dart';
import '../pages/notifications_page.dart';

class NotificationBadge extends StatefulWidget {
  const NotificationBadge({
    super.key,
  });

  @override
  State<NotificationBadge> createState() =>
      _NotificationBadgeState();
}

class _NotificationBadgeState
    extends State<NotificationBadge> {

  final NotificationController controller =
      NotificationController.instance;

  @override
  void initState() {
    super.initState();

    controller.addListener(_refresh);

   WidgetsBinding.instance.addPostFrameCallback((_) {
  controller.refreshBadge();
});
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);

    super.dispose();
  }

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
          ),
          tooltip: 'Notificações',
          onPressed: () async {

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const NotificationsPage(),
              ),
            );

            controller.refreshBadge();
          },
        ),

        if (controller.unreadCount > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                controller.unreadCount > 99
                    ? '99+'
                    : controller.unreadCount
                        .toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}