import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_image.dart';

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
          if (i > 0) SizedBox(width: AppSpacing.s24.w),
          GestureDetector(
            onTap: onTap == null ? null : () => onTap!(asset),
            child: AppImage(asset, width: 36.r, height: 36.r),
          ),
        ],
      ],
    );
  }
}
