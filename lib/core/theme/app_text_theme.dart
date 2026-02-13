import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static const textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimary,
      fontFamily: 'Inter',
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
      fontFamily: 'Inter',
    ),
  );
}
