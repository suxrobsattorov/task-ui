import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import 'app_image.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child, this.opacity = 0.42});

  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bg,
      child: Stack(
        children: [
          Positioned(
            left: -31,
            top: 128,
            width: 421,
            height: 724,
            child: Opacity(
              opacity: opacity,
              child: const AppImage(AppAssets.bgCircuit, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
