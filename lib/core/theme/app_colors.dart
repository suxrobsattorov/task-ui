import 'package:flutter/painting.dart';

/// Single source of truth for all colors in the app.
///
/// The values below are **neutral placeholders** so the project compiles.
/// Replace each token with the exact HEX from Figma — never invent colors.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFF2F6BFF);
  static const Color primaryDark = Color(0xFF1E47B0);

  // Surfaces
  static const Color background = Color(0xFFF6F7FB);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Lines
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFEEF0F3);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Generic
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
