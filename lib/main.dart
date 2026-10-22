import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes.dart';
import 'package:flutter_provider_straterkit/configs/utils/routes/routes_name.dart';
import 'package:flutter_provider_straterkit/l10n/app_localizations.dart';
import 'package:flutter_provider_straterkit/theme/app_theme.dart';
import 'package:flutter_provider_straterkit/theme/theme_provider.dart';
import 'package:flutter_provider_straterkit/localization/language_change_provider.dart';
import 'package:flutter_provider_straterkit/view_model/authview_model/login_logout_view_model.dart';
import 'package:flutter_provider_straterkit/view_model/post_view_model/post_view_model.dart';
import 'package:flutter_provider_straterkit/view_model/userview_model/userview_model.dart';
import 'package:provider/provider.dart';
import 'configs/services/navigator_services/navigator_services_refreshToken.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {}

  final themeProvider = ThemeProvider();
  await themeProvider.initializeTheme();

  final languageProvider = LanguageChangeProvider();
  await languageProvider.getLanguage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<LanguageChangeProvider>.value(value: languageProvider),
        ChangeNotifierProvider(create: (_) => LoginLogoutViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageChangeProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        final locale = languageProvider.appLocale ?? const Locale('en');
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Provider Starter Kit',
          themeMode: themeProvider.themeMode,
          theme: AppTheme.light(locale),
          darkTheme: AppTheme.dark(locale),
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('bn')],
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );
  }
}
