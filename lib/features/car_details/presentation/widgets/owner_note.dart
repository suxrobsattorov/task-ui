import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_container.dart';

class OwnerNote extends StatelessWidget {
  const OwnerNote({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: GlassContainer(
              borderRadius: AppRadius.full100,
              child: Center(
                child: Text(
                  AppStrings.ownerNote,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body16,
                ),
              ),
            ),
          ),
          Positioned(left: 12.w, top: -12.h, child: const _ChatBadge()),
        ],
      ),
    );
  }
}

class _ChatBadge extends StatelessWidget {
  const _ChatBadge();

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: AppRadius.full100,
      blurSigma: 16,
      child: SizedBox(
        width: 24.r,
        height: 24.r,
        child: Center(
          child: AppImage(AppAssets.icChat, width: 16.r, height: 16.r),
        ),
      ),
    );
  }
}
