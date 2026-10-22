class ServiceReconnector {
  /// Basic service reconnector — use when needed
  static final ServiceReconnector _instance = ServiceReconnector._internal();
  factory ServiceReconnector() => _instance;
  ServiceReconnector._internal();
}
