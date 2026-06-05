import 'package:flutter/painting.dart';

/// Color tokens extracted 1:1 from the Figma "Candidate Test" (dark theme).
abstract final class AppColors {
  // Base
  static const Color bg = Color(0xFF040811); // page background / plate ink
  static const Color accent = Color(0xFF00D1FF); // cyan accent
  static const Color green = Color(0xFF00C950); // call buttons
  static const Color flagBlue = Color(0xFF0099B5);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(
    0xFF9CA3AF,
  ); // placeholders, timestamps, idle icons
  static const Color white = Color(0xFFFFFFFF);

  // Glass / lines
  static const Color glassTint = Color(0xFF0F172A); // base fill behind blur
  static const Color glassBorder = Color(0x1FFFFFFF); // white ~12%
  static const Color divider = Color(0xFF1C202A); // bottom-bar hairline

  // Derived (opacity-baked)
  static const Color bubbleFill = Color(0x3300D1FF); // accent @ 20%
  static const Color accentGlow = Color(0x9900D1FF); // accent @ 60%
  static const Color sendNotifFill = Color(0x3300D1FF); // accent @ 20%
  static const Color scrim = Color(0x99000000); // QR dark overlay @ 60%
}
