import 'package:flutter/material.dart';

class AppColors {
  static const Color kPrimaryColor = Color(0xffe86f25);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed: AppColors.kPrimaryColor,
    iconTheme: const IconThemeData(
      color: AppColors.kPrimaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
    iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
  );
}
