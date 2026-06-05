import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_circle_button.dart';

/// "Сканировать QR-код" — camera viewfinder with the scannable iQuarix sticker.
class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key, this.onScanned});

  final VoidCallback? onScanned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: AppImage(AppAssets.bgCamera, fit: BoxFit.cover),
          ),
          const Positioned.fill(child: ColoredBox(color: AppColors.scrim)),

          // Viewfinder frame + scannable sticker (tap to "scan").
          const Positioned(
            left: 72,
            top: 331,
            child: AppImage(AppAssets.qrFrame, width: 250, height: 250),
          ),
          Positioned(
            left: 93,
            top: 312,
            child: GestureDetector(
              onTap: onScanned,
              child: const AppImage(
                AppAssets.qrSticker,
                width: 214,
                height: 268,
              ),
            ),
          ),

          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: AppHeader(title: AppStrings.qrTitle),
          ),

          // Bottom actions: flash · flip camera.
          Positioned(
            left: 20,
            top: 757,
            child: GlassCircleButton(
              size: 60,
              onTap: () {},
              child: const AppImage(AppAssets.icFlash, width: 30, height: 30),
            ),
          ),
          Positioned(
            left: 313,
            top: 757,
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
