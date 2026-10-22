import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0xFF514DEC);
  static const Color secondary = Color(0xFF7C78F5);
  static const Color error = Color(0xFFE84D4F);
  static const Color success = Color(0xFF16A34A);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF9E9E9E);

  static Color textPrimary(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFFF5F5F5) : const Color(0xFF1A1A2E);
  static Color textSecondary(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFFB0B0C0) : const Color(0xFF6B7280);
  static Color subtitle(BuildContext c) => textSecondary(c);
  static Color containerBackground(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF26242B) : AppColors.whiteColor;
  static Color border(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB);
  static Color button(BuildContext c) => primary;
  static Color fieldColor(BuildContext c) => textFieldFill(c);
  static Color hintColor(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF71717A) : const Color(0xFF9CA3AF);
  static Color textFieldFill(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF27272A) : const Color(0xFFF3F4F6);
  // Additional theme-linked colors
  static Color appBackground(BuildContext c) => containerBackground(c);
  static Color showDialougeBackground(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF1A1A1A) : Colors.black.withOpacity(0.5);
  static Color flushbarColor(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? const Color(0xFF333333) : const Color(0xFFE5E7EB);
}

