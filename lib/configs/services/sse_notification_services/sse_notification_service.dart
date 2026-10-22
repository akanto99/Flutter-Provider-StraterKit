import 'dart:async';
import 'dart:convert';
import 'package:flutter_provider_straterkit/configs/res/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// SSE Notification Service - Basic Foundation
class SSENotificationService {
  static final SSENotificationService _instance =
      SSENotificationService._internal();
  factory SSENotificationService() => _instance;
  SSENotificationService._internal();

  http.Client? _client;
  StreamController<Map<String, dynamic>>? _notificationStreamController;

  bool _isListening = false;
  String? _currentEventType;
  StringBuffer _dataBuffer = StringBuffer();
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  Timer? _reconnectTimer;

  // Notification Count
  final StreamController<int> _notificationCountController =
      StreamController<int>.broadcast();
  final StreamController<int> _notificationIncrementController =
      StreamController<int>.broadcast();
  final StreamController<int> _runningOrderCountController =
      StreamController<int>.broadcast();

  int _currentCount = 0;
  int _currentRunningOrderCount = 0;

  // Public Streams
  Stream<Map<String, dynamic>> get notificationStream =>
      _notificationStreamController?.stream ?? Stream.empty();
  Stream<int> get notificationCountStream =>
      _notificationCountController.stream;
  Stream<int> get notificationIncrementStream =>
      _notificationIncrementController.stream;
  Stream<int> get runningOrderCountStream =>
      _runningOrderCountController.stream;

  // Public Getters
  int get currentCount => _currentCount;
  int get currentRunningOrderCount => _currentRunningOrderCount;
  bool get isListening => _isListening;

  /// Start listening to SSE
  Future<void> startListening() async {
    if (_isListening) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    if (accessToken == null || accessToken.isEmpty) return;

    _client = http.Client();
    _notificationStreamController =
        StreamController<Map<String, dynamic>>.broadcast();
    _isListening = true;

    try {
      final url = Uri.parse('${AppUrl.baseUrl}/notifications/stream');
      final request = http.Request('GET', url);
      request.headers['Accept'] = 'text/event-stream';
      request.headers['Cache-Control'] = 'no-cache';
      request.headers['Connection'] = 'keep-alive';
      request.headers['Authorization'] = accessToken;

      final response = await _client!.send(request);

      if (response.statusCode == 200) {
        _reconnectAttempts = 0;
        response.stream
            .transform(utf8.decoder)
            .transform(const LineSplitter())
            .listen(
              (line) => _handleSSELine(line),
              onError: (error) => _reconnect(),
              onDone: () => _reconnect(),
              cancelOnError: false,
            );
      } else {
        if (response.statusCode == 401) {
          await stopListening();
        } else {
          _reconnect();
        }
      }
    } catch (e) {
      _reconnect();
    }
  }

  void _handleSSELine(String line) {
    if (line.isEmpty) {
      if (_dataBuffer.isNotEmpty) {
        _processEvent();
      }
      _currentEventType = null;
      _dataBuffer.clear();
      return;
    }

    if (line.startsWith('event:')) {
      _currentEventType = line.substring(6).trim();
    } else if (line.startsWith('data:')) {
      final dataLine = line.substring(5).trim();
      if (dataLine.isNotEmpty) {
        if (_dataBuffer.isNotEmpty) _dataBuffer.write('\n');
        _dataBuffer.write(dataLine);
      }
    }
  }

  void _processEvent() {
    try {
      final jsonData = _dataBuffer.toString().trim();
      if (jsonData.isEmpty) return;

      // Handle different event types
      switch (_currentEventType) {
        case 'init':
        case 'notificationCount':
          _handleNotificationCount(jsonData);
          break;
        case 'notificationIncrement':
          _handleNotificationIncrement(jsonData);
          break;
        case 'runningOrderCount':
          _handleRunningOrderCount(jsonData);
          break;
        case 'notification':
          final data = json.decode(jsonData) as Map<String, dynamic>;
          _notificationStreamController?.add(data);
          break;
        case 'connected':
        case 'ping':
          // Ignore these events
          break;
        default:
          // Try to parse as generic notification
          try {
            final data = json.decode(jsonData) as Map<String, dynamic>;
            _notificationStreamController?.add(data);
          } catch (_) {}
      }
    } catch (e) {
      // Silently ignore parse errors
    }
  }

  void _handleNotificationCount(String jsonData) {
    try {
      // Try parsing as plain integer first
      try {
        final count = int.parse(jsonData);
        _currentCount = count;
        _notificationCountController.add(count);
        return;
      } catch (_) {}

      // Try parsing as JSON
      final data = json.decode(jsonData);
      if (data is Map && data.containsKey('notificationCount')) {
        final count = data['notificationCount'] as int;
        _currentCount = count;
        _notificationCountController.add(count);
      }
    } catch (e) {
      // Silently ignore
    }
  }

  void _handleNotificationIncrement(String jsonData) {
    try {
      final increment = int.parse(jsonData);
      _currentCount += increment;
      _notificationCountController.add(_currentCount);
      _notificationIncrementController.add(increment);
    } catch (e) {
      // Silently ignore
    }
  }

  void _handleRunningOrderCount(String jsonData) {
    try {
      final count = int.parse(jsonData);
      _currentRunningOrderCount = count;
      _runningOrderCountController.add(count);
    } catch (e) {
      // Silently ignore
    }
  }

  void _reconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      stopListening();
      return;
    }

    _reconnectAttempts++;
    final delay = Duration(seconds: 2 * _reconnectAttempts);

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      stopListening();
      startListening();
    });
  }

  /// Stop listening to SSE
  Future<void> stopListening() async {
    _isListening = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _client?.close();
    _client = null;
    await _notificationStreamController?.close();
    _notificationStreamController = null;
    _reconnectAttempts = 0;
  }

  /// Dispose all resources
  void dispose() {
    stopListening();
    _notificationCountController.close();
    _notificationIncrementController.close();
    _runningOrderCountController.close();
  }
}
