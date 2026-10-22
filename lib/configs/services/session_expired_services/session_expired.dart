import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/services/navigator_services/navigator_services_refreshToken.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_straterkit/view_model/authview_model/login_logout_view_model.dart';

class SessionExpiredService {
  // Use NavigationService's navigatorKey
  static GlobalKey<NavigatorState> get navigatorKey =>
      NavigationService.navigatorKey;

  /// Show session expired dialog
  Future<void> showSessionExpiredDialog() async {
    final context = navigatorKey.currentContext;

    if (context == null || !context.mounted) {
      return;
    }

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false, // Prevent back button
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Session Expired',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Your session has expired. Please login again to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // 1. Close dialog
                        Navigator.of(dialogContext).pop();

                        // 2. Perform logout
                        final loginLogoutViewModel =
                            Provider.of<LoginLogoutViewModel>(
                              context,
                              listen: false,
                            );
                        await loginLogoutViewModel.logoutUser(context);

                        // 3. Navigate to welcome screen
                        if (context.mounted) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            RoutesName.authLoginWelcome,
                            (Route<dynamic> route) => false,
                          );
                        }
                      } catch (e) {
                        // Handle error if needed
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Login Again'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Handle session expired - show dialog or navigate
  Future<void> handleSessionExpired() async {
    try {
      await showSessionExpiredDialog();
    } catch (e) {
      // Fallback: If dialog fails, navigate directly
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RoutesName.authLoginWelcome,
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
