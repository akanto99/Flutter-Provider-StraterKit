import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

/// OneSignal Push Notification Service - Basic Foundation
class OneSignalNotificationService {
  static final OneSignalNotificationService _instance =
      OneSignalNotificationService._internal();
  factory OneSignalNotificationService() => _instance;
  OneSignalNotificationService._internal();

  bool _isInitialized = false;
  String? _currentUserId;

  /// Initialize OneSignal with App ID from .env
  Future<void> initialize() async {
    if (_isInitialized) {
      developer.log('OneSignal already initialized', name: 'OneSignal');
      return;
    }

    try {
      // Get OneSignal App ID from .env
      final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'];
      if (oneSignalAppId == null || oneSignalAppId.isEmpty) {
        throw Exception('ONESIGNAL_APP_ID not found in .env file');
      }

      // Initialize OneSignal
      OneSignal.initialize(oneSignalAppId);

      // Request notification permission
      await OneSignal.Notifications.requestPermission(true);

      // Setup notification handlers
      _setupNotificationHandlers();

      _isInitialized = true;
      developer.log('OneSignal initialized successfully', name: 'OneSignal');
    } catch (e) {
      developer.log(
        'Error initializing OneSignal: $e',
        name: 'OneSignal',
        error: e,
      );
      rethrow;
    }
  }

  /// Setup notification event handlers
  void _setupNotificationHandlers() {
    // Handle foreground notification received
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      final notification = event.notification;
      final title = notification.title ?? 'Notification';
      final body = notification.body ?? '';
      final data = notification.additionalData ?? {};

      developer.log(
        '📬 Foreground Notification: $title - $body',
        name: 'OneSignal',
      );
      developer.log('📦 Data: $data', name: 'OneSignal');

      // Display the notification
      event.notification.display();
    });

    // Handle notification click/tap
    OneSignal.Notifications.addClickListener((event) {
      developer.log(
        '🔔 Notification clicked: ${event.notification.title}',
        name: 'OneSignal',
      );
      // Can handle navigation or custom logic here when uncommented
      // _handleNotificationClick(event);
    });

    // Monitor permission changes
    OneSignal.Notifications.addPermissionObserver((state) {
      developer.log('📲 Notification permission: $state', name: 'OneSignal');
    });
  }

  /// Handle notification click - OPTIONAL: Uncomment when needed
  /// void _handleNotificationClick(OSNotificationClickEvent event) {
  ///   final notification = event.notification;
  ///   final data = notification.additionalData ?? {};
  ///
  ///   developer.log('Handling notification click with data: $data', name: 'OneSignal');
  ///
  ///   // Example: Extract routing data
  ///   // final orderId = data['orderId']?.toString();
  ///   // final route = data['route']?.toString();
  ///
  ///   // Example: Navigate to specific screen
  ///   // if (orderId != null && route != null) {
  ///   //   NavigationService().navigateTo(route, arguments: {'orderId': orderId});
  ///   // }
  /// }

  /// Login user to OneSignal (for targeted notifications)
  Future<void> loginUser(String userId) async {
    if (!_isInitialized) {
      developer.log(
        'OneSignal not initialized, initializing now...',
        name: 'OneSignal',
      );
      await initialize();
    }

    try {
      await OneSignal.login(userId);
      _currentUserId = userId;

      // Save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('onesignal_user_id', userId);

      developer.log(
        '✅ User logged in to OneSignal: $userId',
        name: 'OneSignal',
      );
    } catch (e) {
      developer.log('❌ Error logging in user: $e', name: 'OneSignal', error: e);
      rethrow;
    }
  }

  /// Logout user from OneSignal
  Future<void> logoutUser() async {
    if (!_isInitialized) {
      developer.log('OneSignal not initialized', name: 'OneSignal');
      return;
    }

    try {
      await OneSignal.logout();
      _currentUserId = null;

      // Clear from local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('onesignal_user_id');

      developer.log('👋 User logged out from OneSignal', name: 'OneSignal');
    } catch (e) {
      developer.log('Error logging out: $e', name: 'OneSignal', error: e);
    }
  }

  /// Auto-login if user exists in SharedPreferences - OPTIONAL
  /// Uncomment to use
  /// Future<void> autoLogin() async {
  ///   try {
  ///     final prefs = await SharedPreferences.getInstance();
  ///     final userId = prefs.getString('userId');
  ///
  ///       await loginUser(userId);
  ///     }
  ///   } catch (e) {
  ///     developer.log('Error in auto-login: $e', name: 'OneSignal', error: e);
  ///   }
  /// }

  /// Get current logged-in user ID
  String? getCurrentUserId() {
    return _currentUserId;
  }

  /// Check if OneSignal is initialized
  bool get isInitialized => _isInitialized;
}
