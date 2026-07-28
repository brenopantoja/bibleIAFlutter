import 'package:bibliaia/core/notifications/notification_scheduler.dart';
import 'package:bibliaia/core/notifications/notification_service.dart';

class NotificationInitializer {
  NotificationInitializer._();

  static Future<void> initialize() async {
    await NotificationService.instance.initialize();

    await NotificationScheduler.instance.initialize();
  }
}