import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/view/auth_login/forgot_password_screen.dart';
import 'package:flutter_provider_straterkit/view/auth_login/login_screen.dart';
import 'package:flutter_provider_straterkit/view/auth_login/register_screen.dart';
import 'package:flutter_provider_straterkit/view/auth_login/welcome_login_screen.dart';
import 'package:flutter_provider_straterkit/view/navigation_bar.dart';
import 'package:flutter_provider_straterkit/view/onboarding/onboarding_update.dart';
import 'package:flutter_provider_straterkit/view/screens/home/home_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/posts/create_post_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/posts/post_detail_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/posts/post_list_screen.dart';
import 'package:flutter_provider_straterkit/view/screens/profile/profile_screen.dart';
import 'package:flutter_provider_straterkit/view/splash_screen/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Onboarding & Auth
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesName.onBoardUpdated:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreenUpdated(),
        );

      case RoutesName.authLoginWelcome:
        return MaterialPageRoute(builder: (_) => const WelcomeLoginScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutesName.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      // Main App
      case RoutesName.navigationBar:
        final args = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => NavigationScreen(initialIndex: args ?? 0),
        );

      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RoutesName.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      // Post CRUD Examples
      case RoutesName.postList:
        return MaterialPageRoute(builder: (_) => const PostListScreen());

      case RoutesName.postDetail:
        final postId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => PostDetailScreen(postId: postId),
        );

      case RoutesName.createPost:
        return MaterialPageRoute(builder: (_) => const CreatePostScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(body: Center(child: Text('No route defined')));
      },
    );
  }
}
