import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_image.dart';

/// Uzbek license plate ("01 Z 011 DD") — exported from Figma as an image so the
/// special FE-Schrift plate font renders exactly. Aspect ratio is fixed 197:50.
class LicensePlate extends StatelessWidget {
  const LicensePlate({super.key, this.width = 197});

  final double width;

  @override
  Widget build(BuildContext context) {
    return AppImage(
      AppAssets.plate,
      width: width,
      height: width * 50 / 197,
      fit: BoxFit.contain,
    );
  }
}
