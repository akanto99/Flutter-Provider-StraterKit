class TokenManager {
  /// Basic token manager — use when needed
  static final TokenManager _instance = TokenManager._internal();
  factory TokenManager() => _instance;
  TokenManager._internal();
}
