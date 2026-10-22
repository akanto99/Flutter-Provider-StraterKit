import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color containerBackground;
  final Color border;
  final Color hint;
  final Color textFieldFill;
  final Color subtitle;
  final Color textSecondary;
  final Color success;

  const AppColorsExtension({
    required this.containerBackground,
    required this.border,
    required this.hint,
    required this.textFieldFill,
    required this.subtitle,
    required this.textSecondary,
    required this.success,
  });

  static const light = AppColorsExtension(
    containerBackground: Color(0xFFF5F5F5),
    border: Color(0xFFE0E0E0),
    hint: Color(0xFF888888),
    textFieldFill: Color(0xFFF9F9F9),
    subtitle: Color(0xFF666666),
    textSecondary: Color(0xFF444444),
    success: Color(0xFF22C55E),
  );

  static const dark = AppColorsExtension(
    containerBackground: Color(0xFF1A1A1A),
    border: Color(0xFF333333),
    hint: Color(0xFFAAAAAA),
    textFieldFill: Color(0xFF2A2A2A),
    subtitle: Color(0xFFAAAAAA),
    textSecondary: Color(0xFFCCCCCC),
    success: Color(0xFF4ADE80),
  );

  @override
  AppColorsExtension copyWith({
    Color? containerBackground,
    Color? border,
    Color? hint,
    Color? textFieldFill,
    Color? subtitle,
    Color? textSecondary,
    Color? success,
  }) {
    return AppColorsExtension(
      containerBackground: containerBackground ?? this.containerBackground,
      border: border ?? this.border,
      hint: hint ?? this.hint,
      textFieldFill: textFieldFill ?? this.textFieldFill,
      subtitle: subtitle ?? this.subtitle,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      containerBackground: Color.lerp(containerBackground, other.containerBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

extension ThemeContext on BuildContext {
  ColorScheme get cs => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  AppColorsExtension get colors => Theme.of(this).extension<AppColorsExtension>() ?? (Theme.of(this).brightness == Brightness.dark ? AppColorsExtension.dark : AppColorsExtension.light);
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
