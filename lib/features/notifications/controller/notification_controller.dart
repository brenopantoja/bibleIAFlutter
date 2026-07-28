import 'package:flutter/foundation.dart';

import '../models/notification_item.dart';
import '../repository/notification_repository.dart';

class NotificationController extends ChangeNotifier {
  NotificationController._();

  static final NotificationController instance =
      NotificationController._();

  final NotificationRepository _repository =
      NotificationRepository.instance;

  List<NotificationItem> _notifications = [];

  int _unreadCount = 0;

  bool _loading = false;

  List<NotificationItem> get notifications =>
      List.unmodifiable(_notifications);

  int get unreadCount => _unreadCount;

  bool get isLoading => _loading;

  /// Carrega todas as notificações
Future<void> load() async {

  _loading = true;

  _notifications =
      await _repository.findAll();

  _unreadCount =
      await _repository.countUnread();

  _loading = false;

  notifyListeners();
}

  /// Salva uma nova notificação
  Future<void> save(
    NotificationItem item,
  ) async {
    await _repository.save(item);

    await load();
  }

  /// Marca uma notificação como lida
  Future<void> markAsRead(
    int id,
  ) async {
    await _repository.markAsRead(id);

    await load();
  }

  /// Marca todas como lidas
  Future<void> markAllAsRead() async {
    await _repository.markAllAsRead();

    await load();
  }

  /// Exclui uma notificação
  Future<void> delete(
    int id,
  ) async {
    await _repository.delete(id);

    await load();
  }

  /// Exclui todas
  Future<void> deleteAll() async {
    await _repository.deleteAll();

    await load();
  }

  /// Recarrega apenas o badge
  Future<void> refreshBadge() async {
    _unreadCount =
        await _repository.countUnread();

    notifyListeners();
  }

  /// Última notificação
  Future<NotificationItem?> latest() {
    return _repository.latest();
  }

  /// Existe alguma notificação?
  Future<bool> exists() {
    return _repository.exists();
  }

  /// Lista somente as não lidas
  Future<List<NotificationItem>> unread() {
    return _repository.findUnread();
  }
  /// Limpa estado da memória
  void clear() {
    _notifications = [];
    _unreadCount = 0;
    notifyListeners();
  }
}