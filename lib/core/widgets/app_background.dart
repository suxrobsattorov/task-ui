import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';
import 'app_image.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.opacity = 0.03,
    this.glow = false,
  });

  final Widget child;
  final double opacity;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.bg,
      child: Stack(
        children: [
          Positioned(
            left: -31.w,
            top: 128.h,
            width: 421.w,
            height: 724.h,
            child: Opacity(
              opacity: opacity,
              child: const AppImage(AppAssets.bgCircuit, fit: BoxFit.cover),
            ),
          ),
          if (glow)
            Positioned(
              left: 69.w,
              top: 293.h,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 50,
                  sigmaY: 50,
                  tileMode: TileMode.decal,
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 255.w,
                    height: 65.h,
                    child: const ColoredBox(color: AppColors.accent),
                  ),
                ),
              ),
            ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
