import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Typography tokens (Inter). `height` = Figma lineHeightPx / fontSize.
abstract final class AppTextStyles {
  static const String _f = 'Inter';

  /// Screen titles, section headers, car name, selected notification (18 / 600).
  static const TextStyle title18 = TextStyle(
    fontFamily: _f,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: -0.018,
    color: AppColors.textPrimary,
  );

  /// Smaller section header — "Социальные сети владельца:" (16 / 600).
  static const TextStyle title16 = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    color: AppColors.textPrimary,
  );

  /// Non-selected notification, larger (18 / 500).
  static const TextStyle notif18 = TextStyle(
    fontFamily: _f,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 24 / 18,
    letterSpacing: -0.018,
    color: AppColors.textPrimary,
  );

  /// Non-selected notification, smaller (16 / 500).
  static const TextStyle notif16 = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
    color: AppColors.textPrimary,
  );

  /// Info-bubble / input text (16 / 400).
  static const TextStyle body16 = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  /// Button labels (16 / 600). Color is overridden per button.
  static const TextStyle button = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    color: AppColors.accent,
  );

  /// Chat message / voice duration text (14 / 400).
  static const TextStyle message = TextStyle(
    fontFamily: _f,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  /// Timestamps under bubbles (12 / 500).
  static const TextStyle timestamp = TextStyle(
    fontFamily: _f,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.024,
    color: AppColors.textMuted,
  );

  /// Input placeholder (16 / 400, muted).
  static const TextStyle placeholder = TextStyle(
    fontFamily: _f,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.textMuted,
  );
}
