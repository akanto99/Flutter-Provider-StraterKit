class AppUrl {
  static var baseUrl =
      'http://10.0.2.2:5001/api/v1'; // Local (Android emulator -> host localhost)
  static var socketUrl = 'http://10.0.2.2:5001'; // Local

  static var loginEndPint = baseUrl + '/auth/login';
  static var logOutEndPoint = baseUrl + '/auth/logout';
}
