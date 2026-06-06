import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';

class CarShowcase extends StatelessWidget {
  const CarShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(AppAssets.logoChevrolet, width: 48.r, height: 48.r),
            SizedBox(width: 12.w),
            Text(
              AppStrings.carName,
              style: AppTextStyles.title18.copyWith(
                shadows: const [
                  Shadow(color: Color(0x40000000), blurRadius: 6),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 210.w,
              height: 22.h,
              margin: EdgeInsets.only(bottom: 6.h),
              decoration: BoxDecoration(
                borderRadius: AppRadius.full100,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x7300D1FF),
                    blurRadius: 80,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
            AppImage(
              AppAssets.carOnix,
              width: 300.w,
              height: 160.h,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ],
    );
  }
}
