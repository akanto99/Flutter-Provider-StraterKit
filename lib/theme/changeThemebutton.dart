import 'package:flutter/material.dart';
import 'package:flutter_provider_straterkit/configs/res/color.dart';
import 'package:flutter_provider_straterkit/theme/theme_provider.dart';
import 'package:flutter_provider_straterkit/theme/app_colors_extension.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Switch.adaptive(
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (v) => themeProvider.setThemeMode(v ? ThemeMode.dark : ThemeMode.light),
      activeColor: context.colors.containerBackground == const Color(0xFF1A1A1A) ? AppColors.whiteColor : const Color(0xFF514DEC),
    );
  }
}
