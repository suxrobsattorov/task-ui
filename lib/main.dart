import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'core/widgets/gap.dart';

void main() {
  runApp(const TaskUiApp());
}

class TaskUiApp extends StatelessWidget {
  const TaskUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _FoundationPlaceholder(),
    );
  }
}

/// Temporary screen — confirms the design system is wired up.
/// Replaced by the first real feature page once the Figma is provided.
class _FoundationPlaceholder extends StatelessWidget {
  const _FoundationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppSpacing.s64,
                height: AppSpacing.s64,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.br20,
                  boxShadow: AppShadows.card,
                ),
                child: const Icon(Icons.check_rounded, color: AppColors.white),
              ),
              const Gap(AppSpacing.s24),
              const Text('Design system tayyor', style: AppTextStyles.h2),
              const Gap(AppSpacing.s8),
              const Text(
                'Pixel-perfect ekranlar uchun Figma dizaynini yuboring.',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
