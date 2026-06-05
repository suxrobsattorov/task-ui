import 'package:flutter/material.dart';

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
            const AppImage(AppAssets.logoChevrolet, width: 48, height: 48),
            const SizedBox(width: 12),
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
        const SizedBox(height: 24),
        SizedBox(
          height: 137,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 210,
                height: 22,
                margin: const EdgeInsets.only(bottom: 6),
                decoration: const BoxDecoration(
                  borderRadius: AppRadius.full100,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x7300D1FF),
                      blurRadius: 80,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
              const AppImage(AppAssets.carOnix, width: 259, height: 137),
            ],
          ),
        ),
      ],
    );
  }
}
