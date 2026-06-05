import 'package:flutter/material.dart';

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
      height: 56,
      child: Stack(
        children: [
          Center(child: Text(title, style: AppTextStyles.title18)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.gutter),
              child: GlassCircleButton(
                size: 36,
                onTap: onBack ?? () => Navigator.maybePop(context),
                child: const AppImage(
                  AppAssets.icBack,
                  width: 20,
                  height: 20,
                  color: Color(0XFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
