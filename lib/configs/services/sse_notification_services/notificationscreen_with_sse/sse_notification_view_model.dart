import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter_provider_straterkit/configs/services/sse_notification_services/notificationscreen_with_sse/get_ssc_nofication_model.dart';

/// Notification ViewModel - Basic Foundation
class NotificationViewModel extends ChangeNotifier {
  // List of notifications
  List<GetSseNotificationModel> _notifications = [];
  StreamSubscription<Map<String, dynamic>>? _notificationSubscription;
  bool _isLoading = false;

  // Getters
  List<GetSseNotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;
  bool get hasNotifications => _notifications.isNotEmpty;
  int get notificationCount => _notifications.length;
  int get unreadCount =>
      _notifications.where((n) => n.ssePayload?.read != true).length;

  /// Initialize notification listener
  void initializeNotificationListener(
    Stream<Map<String, dynamic>> notificationStream,
  ) {
    _notificationSubscription?.cancel();
    _notificationSubscription = notificationStream.listen(
      (notificationData) => _handleNewNotification(notificationData),
      onError: (error) {},
      onDone: () {},
      cancelOnError: false,
    );
  }

  void _handleNewNotification(Map<String, dynamic> data) {
    try {
      final notification = GetSseNotificationModel.fromJson(data);
      _notifications.insert(0, notification);
      notifyListeners();
    } catch (e) {
      // Silently ignore parse errors
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final index = _notifications.indexWhere(
        (n) => n.ssePayload?.id == notificationId,
      );
      if (index != -1) {
        _notifications[index].ssePayload?.read = true;
        notifyListeners();
      }
    } catch (e) {
      // Handle error
    }
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    try {
      for (var notification in _notifications) {
        notification.ssePayload?.read = true;
      }
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  /// Clear all notifications
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  /// Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }
}
