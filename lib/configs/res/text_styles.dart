import 'package:flutter/material.dart';
class AppTextStyles {
  static TextStyle heading(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.displayMedium?.copyWith(fontWeight: weight ?? FontWeight.w600, color: color) ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle title(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.titleLarge?.copyWith(fontWeight: weight ?? FontWeight.w500, color: color) ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
  static TextStyle body(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.bodyMedium?.copyWith(fontWeight: weight ?? FontWeight.w400, color: color) ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle caption(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.bodySmall?.copyWith(fontWeight: weight ?? FontWeight.w400, color: color) ?? const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle label(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.labelLarge?.copyWith(fontWeight: weight ?? FontWeight.w400, color: color) ?? const TextStyle(fontSize: 10, fontWeight: FontWeight.w400);
  // Size aliases — fixed font sizes, always from AppTextStyles
  static TextStyle textSize28(BuildContext c, {FontWeight? weight, Color? color}) => heading(c, weight: weight, color: color);
  static TextStyle textSize26(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.headlineMedium?.copyWith(fontWeight: weight ?? FontWeight.w600, color: color) ?? const TextStyle(fontSize: 26, fontWeight: FontWeight.w600);
  static TextStyle textSize24(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.headlineSmall?.copyWith(fontWeight: weight ?? FontWeight.w600, color: color) ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static TextStyle textSize22(BuildContext c, {FontWeight? weight, Color? color}) => title(c, weight: weight, color: color); // 22
  static TextStyle textSize20(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.titleMedium?.copyWith(fontWeight: weight ?? FontWeight.w500, color: color) ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  static TextStyle textSize18(BuildContext c, {FontWeight? weight, Color? color}) => Theme.of(c).textTheme.titleSmall?.copyWith(fontWeight: weight ?? FontWeight.w500, color: color) ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static TextStyle textSize16(BuildContext c, {FontWeight? weight, Color? color}) => body(c, weight: weight, color: color); // 16
  static TextStyle textSize14(BuildContext c, {FontWeight? weight, Color? color}) => body(c, weight: weight, color: color); // 14
  static TextStyle textSize12(BuildContext c, {FontWeight? weight, Color? color}) => caption(c, weight: weight, color: color); // 12
  static TextStyle textSize11(BuildContext c, {FontWeight? weight, Color? color}) => caption(c, weight: weight, color: color).copyWith(fontSize: 11); // 11 fixed
  static TextStyle textSize10(BuildContext c, {FontWeight? weight, Color? color}) => label(c, weight: weight, color: color); // 10
}
