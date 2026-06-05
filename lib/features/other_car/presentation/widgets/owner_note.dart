import 'package:flutter/material.dart';

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
      height: 68,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: GlassContainer(
              borderRadius: AppRadius.full100,
              child: const Center(
                child: Text(
                  AppStrings.ownerNote,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body16,
                ),
              ),
            ),
          ),
          const Positioned(left: 12, top: -12, child: _ChatBadge()),
        ],
      ),
    );
  }
}

class _ChatBadge extends StatelessWidget {
  const _ChatBadge();

  @override
  Widget build(BuildContext context) {
    return const GlassContainer(
      borderRadius: AppRadius.full100,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Center(child: AppImage(AppAssets.icChat, width: 16, height: 16)),
      ),
    );
  }
}
