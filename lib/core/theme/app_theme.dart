import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static const SystemUiOverlayStyle overlay = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.bg,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: AppColors.bg,
    canvasColor: AppColors.bg,
    splashColor: AppColors.accent.withValues(alpha: 0.08),
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.bg,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.accent,
      selectionHandleColor: AppColors.accent,
    ),
    textTheme: const TextTheme(bodyMedium: AppTextStyles.body16),
  );
}
