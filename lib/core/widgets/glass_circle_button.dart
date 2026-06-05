import 'package:flutter/material.dart';

import '../theme/app_radius.dart';
import 'glass_container.dart';

/// Circular frosted-glass button (header back arrow, QR action buttons).
class GlassCircleButton extends StatelessWidget {
  const GlassCircleButton({
    super.key,
    required this.size,
    required this.child,
    this.onTap,
    this.borderColor,
    this.boxShadow,
  });

  final double size;
  final Widget child;
  final VoidCallback? onTap;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassContainer(
        borderRadius: AppRadius.full100,
        borderColor: borderColor,
        boxShadow: boxShadow,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
