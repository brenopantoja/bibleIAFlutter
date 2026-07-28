import 'package:bibliaia/core/notifications/notification_service.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/notifications/controller/notification_controller.dart';
import 'package:bibliaia/features/notifications/models/notification_item.dart';
import 'package:bibliaia/features/verses/datasource/verse_remote_datasource.dart';

class VerseNotificationService {
  VerseNotificationService();

  final VerseRemoteDatasource datasource =
      const VerseRemoteDatasource();

  Future<void> sendVerseNotification() async {
    try {
      final language =
          BibleProvider.instance.english
              ? 'EN_US'
              : 'PT_BR';

      final verse =
          await datasource.getVerse(language);

      final notificationId =
          DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final notification = NotificationItem(
        title: verse.reference,
        body: verse.text,
        reference: verse.reference,

        language: verse.language,
        book: verse.book,
        chapter: verse.chapter,
        verse: verse.verse,

        createdAt: DateTime.now(),
      );

      // Salva no SQLite
      await NotificationController.instance.save(
        notification,
      );

      // Exibe a notificação do Android
      await NotificationService.instance.show(
        id: notificationId,
        title: notification.reference,
        body: notification.body,
      );

      // ignore: avoid_print
      print('==============================');

      // ignore: avoid_print
      print('Notificação enviada');

      // ignore: avoid_print
      print('Livro......: ${notification.book}');

      // ignore: avoid_print
      print('Capítulo...: ${notification.chapter}');

      // ignore: avoid_print
      print('Versículo..: ${notification.verse}');

      // ignore: avoid_print
      print('Idioma.....: ${notification.language}');

      // ignore: avoid_print
      print('Referência.: ${notification.reference}');

      // ignore: avoid_print
      print('Texto......: ${notification.body}');

      // ignore: avoid_print
      print('==============================');
    } catch (e, stackTrace) {
      // ignore: avoid_print
      print('Erro ao enviar notificação');

      // ignore: avoid_print
      print(e);

      // ignore: avoid_print
      print(stackTrace);
    }
  }
}