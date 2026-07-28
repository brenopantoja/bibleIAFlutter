import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    await plugin.initialize(
      const InitializationSettings(
        android: android,
      ),
    );

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
  }) async {
    await plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'verse_channel',
          'Verse of Day',
          channelDescription:
              'Daily Bible notifications',
          importance: Importance.max,
          priority: Priority.max,
          playSound: true,
          enableVibration: true,
        ),
      ),
    );
  }

  Future<void> cancel(
    int id,
  ) async {
    await plugin.cancel(id);
  }

  Future<void> cancelAll() async {
    await plugin.cancelAll();
  }
}