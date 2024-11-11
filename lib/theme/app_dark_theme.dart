import 'package:flutter/material.dart';
import 'package:save_money/theme/app_colors.dart';

class AppDarkTheme {
  static final appDarkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.mainTextColor,
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? const TextStyle(color: AppColors.primaryColor)
            : const TextStyle(color: AppColors.disableColor),
      ),
      backgroundColor: AppColors.whiteColor,
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Pretendard',
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
