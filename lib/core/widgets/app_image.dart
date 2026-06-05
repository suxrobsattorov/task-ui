import 'package:flutter/material.dart';

/// Thin wrapper over [Image.asset]. Pass [color] to tint a monochrome glyph
/// (uses srcIn so the alpha shape is recolored).
class AppImage extends StatelessWidget {
  const AppImage(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit,
  });

  final String asset;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: color == null ? null : BlendMode.srcIn,
      filterQuality: FilterQuality.medium,
    );
  }
}
