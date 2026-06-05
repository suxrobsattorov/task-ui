import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/gap.dart';

class NotificationPickerPage extends StatefulWidget {
  const NotificationPickerPage({super.key, this.onSend});

  final ValueChanged<String>? onSend;

  @override
  State<NotificationPickerPage> createState() => _NotificationPickerPageState();
}

class _NotificationPickerPageState extends State<NotificationPickerPage> {
  static const double _titleToBand = 152;

  static const List<double> _fade = [0.40, 0.20, 0.10];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final others = [
      for (var i = 0; i < AppStrings.notifications.length; i++)
        if (i != _selected) i,
    ];

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppHeader(title: AppStrings.detailsTitle),
              const Gap(AppSpacing.s16),
              const Text(
                AppStrings.chooseNotification,
                textAlign: TextAlign.center,
                style: AppTextStyles.title18,
              ),
              const Gap(_titleToBand),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutter,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SelectionBand(text: AppStrings.notifications[_selected]),
                    for (final (rank, i) in others.indexed) ...[
                      const Gap(AppSpacing.s12),
                      _Option(
                        text: AppStrings.notifications[i],
                        opacity: _fade[rank.clamp(0, _fade.length - 1)],
                        big: rank == 0,
                        onTap: () => setState(() => _selected = i),
                      ),
                    ],
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.gutter,
                ),
                child: AppButton(
                  label: AppStrings.send,
                  onTap: () =>
                      widget.onSend?.call(AppStrings.notifications[_selected]),
                ),
              ),
              const Gap(AppSpacing.s24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBand extends StatelessWidget {
  const _SelectionBand({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Column(
        children: [
          const _Divider(),
          Expanded(
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppTextStyles.title18,
              ),
            ),
          ),
          const _Divider(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.white.withValues(alpha: 0.20));
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.text,
    required this.opacity,
    required this.big,
    required this.onTap,
  });

  final String text;
  final double opacity;
  final bool big;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: opacity,
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: big ? AppTextStyles.notif18 : AppTextStyles.notif16,
        ),
      ),
    );
  }
}
