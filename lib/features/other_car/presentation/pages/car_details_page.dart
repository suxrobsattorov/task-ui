import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/glass_button.dart';
import '../widgets/car_showcase.dart';
import '../widgets/license_plate.dart';
import '../widgets/owner_note.dart';
import '../widgets/social_links.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key, this.onSendNotification});

  final VoidCallback? onSendNotification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        glow: true,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppHeader(title: AppStrings.detailsTitle),
                const Gap(AppSpacing.s16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.gutter,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        AppStrings.contactOwner,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title18,
                      ),
                      const Gap(AppSpacing.s24),
                      const CarShowcase(),
                      const Gap(AppSpacing.s12),
                      const Center(child: LicensePlate()),
                      const Gap(AppSpacing.s24),
                      const OwnerNote(),
                      const Gap(AppSpacing.s24),
                      const Text(
                        AppStrings.ownerSocials,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title16,
                      ),
                      const Gap(AppSpacing.s16),
                      const SocialLinks(),
                      const Gap(AppSpacing.s32),
                      Row(
                        children: [
                          Expanded(
                            child: GlassButton(
                              label: AppStrings.call1,
                              borderColor: AppColors.green,
                              textColor: AppColors.green,
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: GlassButton(
                              label: AppStrings.call2,
                              borderColor: AppColors.green,
                              textColor: AppColors.green,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      const Gap(AppSpacing.s24),
                      AppButton(
                        label: AppStrings.sendNotification,
                        onTap: onSendNotification ?? () {},
                      ),
                      const Gap(AppSpacing.s12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
