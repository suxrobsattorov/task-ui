import 'package:flutter/painting.dart';

import 'app_colors.dart';

/// Glow / shadow tokens (mapped from Figma "Effects").
abstract final class AppShadows {
  /// Cyan glow under the primary "Отправить уведомление" button.
  static const List<BoxShadow> accentGlow = [
    BoxShadow(color: AppColors.accentGlow, blurRadius: 50, spreadRadius: -6),
  ];

  /// Subtle green halo around the call buttons.
  static const List<BoxShadow> greenGlow = [
    BoxShadow(color: Color(0x3300C950), blurRadius: 24, spreadRadius: -10),
  ];
}
