import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:bibliaia/features/verses/page/verse_of_day_page.dart';

import '../controller/notification_controller.dart';
import '../models/notification_item.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

  @override
  State<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends State<NotificationsPage> {

  final NotificationController controller =
      NotificationController.instance;

  @override
  void initState() {
    super.initState();

    _load();
  }

  Future<void> _load() async {
    await controller.load();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _markAsRead(
    NotificationItem item,
  ) async {
    if (item.id == null) {
      return;
    }

    await controller.markAsRead(item.id!);

    await _load();
  }

  Future<void> _delete(
    NotificationItem item,
  ) async {
    if (item.id == null) {
      return;
    }

    await controller.delete(item.id!);

    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final notifications =
        controller.notifications;

    return Scaffold(
      appBar: AppBar(
        title: Text(
        AppStrings.notifications,
      ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done_all,
            ),
            tooltip: AppStrings.markAllAsRead,
            onPressed: () async {
              await controller.markAllAsRead();

              await _load();
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_forever,
            ),
            tooltip: AppStrings.deleteAllNotifications,
            onPressed: () async {
              final confirm =
                  await showDialog<bool>(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title:  Text(
                    AppStrings.deleteNotifications,
                    ),
                    content:  Text(
                          AppStrings.delete,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            false,
                          );
                        },
                        child:  Text(
                             AppStrings.delete,
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            true,
                          );
                        },
                        child:  Text(
                             AppStrings.delete,

                        ),
                      ),
                    ],
                  );
                },
              );

              if (confirm != true) {
                return;
              }

              await controller.deleteAll();

              await _load();
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const _EmptyNotifications()
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.separated(
                padding:
                    const EdgeInsets.all(12),
                itemCount:
                    notifications.length,
                separatorBuilder:
                    (_, __) =>
                        const SizedBox(
                          height: 8,
                        ),
                itemBuilder:
                    (context, index) {
                  final item =
                      notifications[index];

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        item.read
                            ? Icons
                                .notifications_none
                            : Icons
                                .notifications_active,
                      ),
                      title: Text(
                        item.reference,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            item.body,
                            maxLines: 3,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            item.createdAt
                                .toString(),
                            style:
                                Theme.of(
                              context,
                            )
                                    .textTheme
                                    .bodySmall,
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder:
                            (_) => [
                                PopupMenuItem(
                            value: 'verse',
                            child: Text(
                              AppStrings.goToVerse,
                            ),
                          ),
                           PopupMenuItem(
                            value: 'read',
                            child: Text(
                        AppStrings.markAsRead,
                            ),
                          ),
                           PopupMenuItem(
                            value: 'delete',
                            child: Text(
                                  AppStrings.delete,
                            ),
                          ),
                        ],
                        onSelected:
                            (value) async {
                          switch (value) {
                                case 'verse':
                                await _goToVerse(item);
                                break;

                            case 'read':
                              await _markAsRead(
                                item,
                              );
                              break;

                            case 'delete':
                              await _delete(
                                item,
                              );
                              break;
                          }
                        },
                      ),
                      onTap: () =>
                          _markAsRead(
                        item,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
      Future<void> _goToVerse(
      NotificationItem item,
      ) async {
      if (item.id != null) {
      await controller.markAsRead(item.id!);
      }

      if (!mounted) {
      return;
      }

      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VerseOfDayPage(),
      ),
      );

      await _load();
      }
}

class _EmptyNotifications
    extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children:  [
            Icon(
              Icons.notifications_off,
              size: 72,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              AppStrings.notificationsEmpty,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  
  }
}