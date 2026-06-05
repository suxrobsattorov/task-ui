import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';

/// Row of the owner's social network icons (36px white glyphs, 24px apart).
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, this.onTap});

  final ValueChanged<String>? onTap;

  static const List<String> _icons = [
    AppAssets.icTelegram,
    AppAssets.icInstagram,
    AppAssets.icFacebook,
    AppAssets.icLinkedin,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final (i, asset) in _icons.indexed) ...[
          if (i > 0) const SizedBox(width: AppSpacing.s24),
          GestureDetector(
            onTap: onTap == null ? null : () => onTap!(asset),
            child: AppImage(asset, width: 36, height: 36),
          ),
        ],
      ],
    );
  }
}
