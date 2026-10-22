import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors_extension.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';

class AppTheme {
  static ThemeData light(Locale locale) {
    final isBn = locale.languageCode == 'bn';
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: isBn ? 'hindSiliguri' : 'poppins',
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF514DEC),
        secondary: Color(0xFF7C78F5),
        error: Color(0xFFE84D4F),
        surface: Color(0xFFF5F5F5),
        background: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
        labelLarge: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFFFFFF),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF9F9F9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF514DEC),
          foregroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFFE0E0E0)),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        contentTextStyle: TextStyle(color: AppColors.whiteColor, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFF5F5F5),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? const Color(0xFF514DEC) : AppColors.greyColor),
      ),
      extensions: const [AppColorsExtension.light],
    );
  }

  static ThemeData dark(Locale locale) {
    final isBn = locale.languageCode == 'bn';
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: isBn ? 'hindSiliguri' : 'poppins',
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF514DEC),
        secondary: Color(0xFF7C78F5),
        error: Color(0xFFE84D4F),
        surface: Color(0xFF1A1A1A),
        background: Color(0xFF121212),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212),
        foregroundColor: AppColors.whiteColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        displayMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: AppColors.whiteColor),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: Colors.white70),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: Colors.white70),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: Colors.white60),
        labelLarge: TextStyle(fontSize: 10, fontWeight: FontWeight.w400, fontFamily: isBn ? 'hindSiliguri' : 'poppins', color: Colors.white60),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF121212),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF333333))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF514DEC),
          foregroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFF333333)),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFFE8E8E8),
        contentTextStyle: TextStyle(color: AppColors.blackColor, fontFamily: isBn ? 'hindSiliguri' : 'poppins'),
      ),
      cardTheme: CardThemeData(
        color: Color(0xFF1A1A1A),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? const Color(0xFF514DEC) : AppColors.greyColor),
      ),
      extensions: const [AppColorsExtension.dark],
    );
  }
}
