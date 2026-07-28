import '../datasource/notification_local_datasource.dart';
import '../models/notification_item.dart';

class NotificationRepository {
  NotificationRepository._();

  static final NotificationRepository instance =
      NotificationRepository._();

  final NotificationLocalDatasource _datasource =
      NotificationLocalDatasource.instance;

  /// Salva uma nova notificação
  Future<int> save(
    NotificationItem item,
  ) {
    return _datasource.save(item);
  }

  /// Retorna todas as notificações
  Future<List<NotificationItem>> findAll() {
    return _datasource.findAll();
  }

  /// Retorna apenas notificações não lidas
  Future<List<NotificationItem>> findUnread() {
    return _datasource.findUnread();
  }

  /// Busca uma notificação pelo ID
  Future<NotificationItem?> findById(
    int id,
  ) {
    return _datasource.findById(id);
  }

  /// Última notificação recebida
  Future<NotificationItem?> latest() {
    return _datasource.latest();
  }

  /// Quantidade de notificações não lidas
  Future<int> countUnread() {
    return _datasource.countUnread();
  }

  /// Existe alguma notificação?
  Future<bool> exists() {
    return _datasource.exists();
  }

  /// Marca uma notificação como lida
  Future<void> markAsRead(
    int id,
  ) {
    return _datasource.markAsRead(id);
  }

  /// Marca todas as notificações como lidas
  Future<void> markAllAsRead() {
    return _datasource.markAllAsRead();
  }

  /// Remove uma notificação
  Future<void> delete(
    int id,
  ) {
    return _datasource.delete(id);
  }

  /// Remove todas as notificações
  Future<void> deleteAll() {
    return _datasource.deleteAll();
  }
}