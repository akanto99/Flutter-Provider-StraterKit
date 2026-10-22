import 'dart:convert';
import 'package:flutter_provider_straterkit/respository/auth_repository/login_logout_repository.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/configs/utils/utils.dart';
import 'package:flutter_provider_straterkit/model/user/user_model.dart';
import 'package:flutter_provider_straterkit/view_model/userview_model/userview_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogoutViewModel with ChangeNotifier {
  final _myRepo = LoginLogoutRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// Login API — simplified for starter kit
  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    try {
      final response = await _myRepo.loginApi(data);
      final user = UserModel.fromJson(response);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      await userPreference.saveUser(user);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', user.data?.accessToken ?? '');
      await prefs.setString('userId', user.data?.user?.userId ?? '');
      await prefs.setString('role', user.data?.user?.role ?? '');

      setLoading(false);
      Utils.flushBarSuccessMessage('Login Successfully', context);

      // Navigate to home screen
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.navigationBar,
          (route) => false,
        );
      }
    } catch (error) {
      setLoading(false);
      _handleError(error, context);
    }
  }

  bool _loggingOut = false;
  bool get loggingOut => _loggingOut;

  setLoggingOut(bool value) {
    _loggingOut = value;
    notifyListeners();
  }

  /// Logout — simplified for starter kit
  Future<void> logoutUser(BuildContext context) async {
    if (_loggingOut) return;
    setLoggingOut(true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? '';
      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      // Call logout API
      try {
        await _myRepo.logoutApi(token).timeout(const Duration(seconds: 10));
      } catch (e) {
        if (kDebugMode) print("⚠️ Logout API failed: $e");
      }

      // Clear local data
      await userPreference.remove();
      await prefs.remove("image");

      setLoggingOut(false);

      if (context.mounted) {
        Utils.flushBarSuccessMessage("Logged out successfully", context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.authLoginWelcome,
          (route) => false,
        );
      }
    } catch (error) {
      setLoggingOut(false);
      _handleError(error, context);
    }
  }

  /// Handle Errors
  void _handleError(dynamic error, BuildContext context) {
    String errorMessage = '$error';
    try {
      String errorBody = error.toString();
      int jsonStartIndex = errorBody.indexOf('{');
      if (jsonStartIndex != -1) {
        final decoded = jsonDecode(errorBody.substring(jsonStartIndex));
        errorMessage =
            decoded['message'] ??
            (decoded['errorMessages'] is List &&
                    decoded['errorMessages'].isNotEmpty
                ? decoded['errorMessages'][0]['message']
                : errorMessage);
      }
    } catch (_) {
      errorMessage = 'Unexpected error occurred';
    }
    Utils.flushBarErrorMessage(errorMessage, context);
  }
}
