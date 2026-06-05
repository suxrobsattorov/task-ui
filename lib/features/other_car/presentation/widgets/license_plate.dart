import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_image.dart';

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
