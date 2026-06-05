import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import 'glass_container.dart';

/// Pill / rounded frosted-glass button used for primary and call actions.
class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 56,
    this.borderRadius = AppRadius.full100,
    this.fill = const Color(0x0AFFFFFF),
    this.borderColor,
    this.textColor = AppColors.accent,
    this.glow,
  });

  final String label;
  final VoidCallback? onTap;
  final double height;
  final BorderRadius borderRadius;
  final Color fill;
  final Color? borderColor;
  final Color textColor;
  final List<BoxShadow>? glow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassContainer(
        borderRadius: borderRadius,
        fill: fill,
        borderColor: borderColor,
        boxShadow: glow,
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.button.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
