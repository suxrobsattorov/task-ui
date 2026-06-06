import 'package:flutter/material.dart';

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
          const Positioned.fill(
            child: CustomPaint(
              painter: _ScrimCutoutPainter(
                cutoutSize: _frameSize,
                radius: 15,
                color: AppColors.scrim,
              ),
            ),
          ),

          Positioned.fill(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const AppImage(
                    AppAssets.qrFrame,
                    width: _frameSize,
                    height: _frameSize,
                  ),
                  GestureDetector(
                    onTap: onScanned,
                    child: const AppImage(
                      AppAssets.qrSticker,
                      width: 214,
                      height: 268,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: AppHeader(title: AppStrings.qrTitle),
          ),

          Positioned(
            left: 20,
            bottom: 35,
            child: GlassCircleButton(
              size: 60,
              onTap: () {},
              child: const AppImage(AppAssets.icFlash, width: 30, height: 30),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 35,
            child: GlassCircleButton(
              size: 60,
              onTap: () {},
              child: const AppImage(
                AppAssets.icCameraFlip,
                width: 30,
                height: 30,
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
      old.cutoutSize != cutoutSize || old.radius != radius || old.color != color;
}
