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
}
