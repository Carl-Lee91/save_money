import 'package:flutter/material.dart';
import 'package:save_money/constants/app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.whiteColor,
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? const TextStyle(color: AppColors.primaryColor)
            : const TextStyle(color: AppColors.disableColor),
      ),
      backgroundColor: AppColors.whiteColor,
    ),
  );
}
