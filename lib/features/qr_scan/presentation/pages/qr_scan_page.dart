import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_circle_button.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key, this.onScanned});

  final VoidCallback? onScanned;

  static const double _frameSize = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 1.4,
              alignment: const Alignment(0, -0.28),
              child: const AppImage(
                AppAssets.bgCamera,
                fit: BoxFit.cover,
                alignment: Alignment(0.45, 0),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _ScrimCutoutPainter(
                cutoutSize: _frameSize.r,
                radius: 15.r,
                color: AppColors.scrim,
              ),
            ),
          ),

          Positioned.fill(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AppImage(
                    AppAssets.qrFrame,
                    width: _frameSize.r,
                    height: _frameSize.r,
                  ),
                  GestureDetector(
                    onTap: onScanned,
                    child: AppImage(
                      AppAssets.qrSticker,
                      width: 214.w,
                      height: 268.h,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 60.h,
            left: 0,
            right: 0,
            child: const AppHeader(title: AppStrings.qrTitle),
          ),

          Positioned(
            left: 20.w,
            bottom: 35.h,
            child: GlassCircleButton(
              size: 60.r,
              onTap: () {},
              child: AppImage(AppAssets.icFlash, width: 30.r, height: 30.r),
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: 35.h,
            child: GlassCircleButton(
              size: 60.r,
              onTap: () {},
              child: AppImage(
                AppAssets.icCameraFlip,
                width: 30.r,
                height: 30.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrimCutoutPainter extends CustomPainter {
  const _ScrimCutoutPainter({
    required this.cutoutSize,
    required this.radius,
    required this.color,
  });

  final double cutoutSize;
  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final cutout = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: cutoutSize,
      height: cutoutSize,
    );
    final overlay = Path()..addRect(Offset.zero & size);
    final hole = Path()
      ..addRRect(RRect.fromRectAndRadius(cutout, Radius.circular(radius)));
    canvas.drawPath(
      Path.combine(PathOperation.difference, overlay, hole),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(_ScrimCutoutPainter old) =>
      old.cutoutSize != cutoutSize ||
      old.radius != radius ||
      old.color != color;
}
