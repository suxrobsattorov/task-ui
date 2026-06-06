import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/glass_container.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final TextMessage message;

  static const double _padding = 12;

  bool get _isMe => message.author == ChatAuthor.me;

  @override
  Widget build(BuildContext context) {
    // A bubble takes at most two-thirds of the screen width, and is sized to
    // hug the text so right-aligned lines leave no empty space inside it.
    final maxWidth = MediaQuery.sizeOf(context).width * 2 / 3;
    final style = DefaultTextStyle.of(
      context,
    ).style.merge(AppTextStyles.message);
    final textWidth = _longestLineWidth(
      style,
      MediaQuery.textScalerOf(context),
      maxWidth - _padding * 2,
    );

    final bubble = GlassContainer(
      borderRadius: _isMe ? AppRadius.br16 : AppRadius.received,
      fill: _isMe ? AppColors.bubbleFill : const Color(0x14FFFFFF),
      padding: const EdgeInsets.all(_padding),
      child: SizedBox(
        width: textWidth,
        child: Text(
          message.text,
          textAlign: _isMe ? TextAlign.right : TextAlign.left,
          style: AppTextStyles.message,
        ),
      ),
    );

    final time = Text(message.time, style: AppTextStyles.timestamp);

    if (_isMe) {
      return Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [bubble, const SizedBox(height: 8), time],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Avatar(),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bubble,
              const SizedBox(height: 8),
              Padding(padding: const EdgeInsets.only(left: 4), child: time),
            ],
          ),
        ),
      ],
    );
  }

  /// Width of the widest line after wrapping at [maxWidth], so the bubble can
  /// shrink-wrap the text instead of stretching to the full max width.
  double _longestLineWidth(TextStyle style, TextScaler scaler, double maxWidth) {
    final painter = TextPainter(
      text: TextSpan(text: message.text, style: style),
      textDirection: TextDirection.ltr,
      textScaler: scaler,
    )..layout(maxWidth: maxWidth);
    var longest = 0.0;
    for (final line in painter.computeLineMetrics()) {
      if (line.width > longest) longest = line.width;
    }
    painter.dispose();
    return longest.ceilToDouble();
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return const GlassContainer(
      borderRadius: AppRadius.full100,
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(child: AppImage(AppAssets.icUser, width: 24, height: 24)),
      ),
    );
  }
}
