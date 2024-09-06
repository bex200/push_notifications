import 'package:flutter/material.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.globalAccentBlue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.globalWhite,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: AppColors.lightBodyLarge,
            fontWeight: FontWeight.w700,
            fontSize: 22),
        bodyMedium: TextStyle(
            color: AppColors.lightBodyMedium,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        bodySmall: TextStyle(color: AppColors.lightBodyMedium, fontSize: 16),
        labelSmall: TextStyle(color: AppColors.lightLableSmall, fontSize: 12),
      ),
      buttonTheme: const ButtonThemeData(buttonColor: AppColors.globalWhite));

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.globalAccentBlue,
      scaffoldBackgroundColor: AppColors.darkBg,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBg,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: AppColors.darkBodyLarge,
            fontWeight: FontWeight.w700,
            fontSize: 22),
        bodyMedium: TextStyle(
            color: AppColors.darkBodyMedium,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        bodySmall: TextStyle(
          color: AppColors.darkBodyMedium,
          fontSize: 16,
        ),
        labelSmall: TextStyle(color: AppColors.darkLableSmall, fontSize: 12),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.globalWhite,
      ));
}
