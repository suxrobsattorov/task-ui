import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';
import 'glass_button.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  static const LinearGradient _border = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D1FF), Color(0x8C231013)],
  );

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      label: label,
      onTap: onTap,
      borderRadius: AppRadius.br30,
      fill: AppColors.bubbleFill,
      borderGradient: _border,
      borderWidth: 3,
      blurSigma: 60,
      innerShadows: const [],
      textColor: AppColors.accent,
      glow: AppShadows.accentGlow,
    );
  }
}
