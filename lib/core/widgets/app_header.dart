import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_assets.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_image.dart';
import 'glass_circle_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
        children: [
          Center(child: Text(title, style: AppTextStyles.title18)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: AppSpacing.gutter.w),
              child: GlassCircleButton(
                size: 36.r,
                onTap: onBack ?? () => Navigator.maybePop(context),
                child: AppImage(
                  AppAssets.icBack,
                  width: 20.r,
                  height: 20.r,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
