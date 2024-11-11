import 'package:flutter/material.dart';
import 'package:save_money/theme/app_colors.dart';

class AppLightTheme {
  static final appLightTheme = ThemeData(
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
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Pretendard',
        color: AppColors.mainTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
