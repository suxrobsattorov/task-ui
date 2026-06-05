import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_container.dart';
import '../models/chat_message.dart';

/// Outgoing voice message: play/pause button + waveform + duration.
class VoiceMessageBubble extends StatelessWidget {
  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.playing,
    required this.onPlayToggle,
  });

  final VoiceMessage message;
  final bool playing;
  final VoidCallback onPlayToggle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GlassContainer(
            borderRadius: AppRadius.br16,
            fill: AppColors.bubbleFill,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PlayPause(playing: playing, onTap: onPlayToggle),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppImage(AppAssets.wave, width: 98, height: 20),
                      const SizedBox(height: 4),
                      Text(message.duration, style: AppTextStyles.message),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(message.time, style: AppTextStyles.timestamp),
        ],
      ),
    );
  }
}

class _PlayPause extends StatelessWidget {
  const _PlayPause({required this.playing, required this.onTap});

  final bool playing;
  final VoidCallback onTap;

  static const double size = 48;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: playing
          ? Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _bar(),
                    SizedBox(width: size * 0.12),
                    _bar(),
                  ],
                ),
              ),
            )
          : AppImage(AppAssets.icPlay, width: size, height: size),
    );
  }

  Widget _bar() => Container(
    width: size * 0.1,
    height: size * 0.34,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
