import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_container.dart';
import '../models/chat_message.dart';

class VoiceMessageBubble extends StatelessWidget {
  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.playing,
    required this.progress,
    required this.label,
    required this.onPlayToggle,
  });

  final VoiceMessage message;
  final bool playing;
  final double progress;
  final String label;
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SizedBox(
              height: 80.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PlayPause(playing: playing, onTap: onPlayToggle),
                  SizedBox(width: 16.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Waveform(progress: progress),
                      SizedBox(height: 4.h),
                      Text(label, style: AppTextStyles.message),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(message.time, style: AppTextStyles.timestamp),
        ],
      ),
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform({required this.progress});

  final double progress;

  static const double _w = 98;
  static const double _h = 20;

  @override
  Widget build(BuildContext context) {
    final base = AppImage(AppAssets.wave, width: _w.w, height: _h.h);
    if (progress <= 0) return base;

    return SizedBox(
      width: _w.w,
      height: _h.h,
      child: Stack(
        children: [
          Opacity(opacity: 0.35, child: base),
          ClipRect(
            clipper: _ProgressClipper(progress),
            child: AppImage(
              AppAssets.wave,
              width: _w.w,
              height: _h.h,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressClipper extends CustomClipper<Rect> {
  const _ProgressClipper(this.progress);

  final double progress;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * progress, size.height);

  @override
  bool shouldReclip(_ProgressClipper oldClipper) =>
      oldClipper.progress != progress;
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
              width: size.r,
              height: size.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _bar(),
                    SizedBox(width: (size * 0.12).r),
                    _bar(),
                  ],
                ),
              ),
            )
          : AppImage(AppAssets.icPlay, width: size.r, height: size.r),
    );
  }

  Widget _bar() => Container(
    width: (size * 0.1).r,
    height: (size * 0.34).r,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(2.r),
    ),
  );
}
