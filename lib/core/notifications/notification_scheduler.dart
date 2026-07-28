import 'package:bibliaia/features/verses/service/verse_notification_service.dart';

class NotificationScheduler {
  NotificationScheduler._();

  static final instance =
      NotificationScheduler._();

  final VerseNotificationService service =
      VerseNotificationService();

  Future<void> initialize() async {}

  Future<void> showNow() async {
    await service.sendVerseNotification();
  }
}