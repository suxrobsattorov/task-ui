import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.recording,
    required this.recordingLabel,
    required this.onSend,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onCancelRecording,
  });

  final bool recording;
  final String recordingLabel;
  final ValueChanged<String> onSend;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onCancelRecording;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    widget.onSend(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // The interactive row is always mounted, so the hold gesture on the
            // mic button keeps receiving the release event while recording.
            _inputRow(),
            if (widget.recording)
              Positioned.fill(
                child: IgnorePointer(child: _recordingOverlay()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _inputRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _pill(child: _textField())),
          const SizedBox(width: 12),
          _hasText
              ? _CircleButton(
                  color: AppColors.accent,
                  glow: AppShadows.accentGlow,
                  onTap: _send,
                  child: const AppImage(
                    AppAssets.icSend,
                    width: 24,
                    height: 24,
                  ),
                )
              : _holdMicButton(),
        ],
      ),
    );
  }

  /// Press and hold to record, release to send (Telegram-style).
  Widget _holdMicButton() {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
        widget.onStartRecording();
      },
      onPointerUp: (_) => widget.onStopRecording(),
      onPointerCancel: (_) => widget.onCancelRecording(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E2430), Color(0xFF1A1E26)],
          ),
        ),
        child: const Center(
          child: AppImage(AppAssets.icMic, width: 24, height: 24),
        ),
      ),
    );
  }

  // Recording state, drawn on top of the input row (visual only): a full-width
  // pill (dot + timer) with an 80px glowing mic button overlapping its right
  // end, flush to the screen edge (Figma 1-7213).
  Widget _recordingOverlay() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _recordingPill(),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: _RecordMicButton(),
        ),
      ],
    );
  }

  Widget _recordingPill() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E2430), Color(0xFF1A1E26)],
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(19)),
          color: AppColors.bg,
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              widget.recordingLabel,
              style: AppTextStyles.body16.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pill({required Widget child}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: AppRadius.br19,
        border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
      ),
      child: Center(child: child),
    );
  }

  Widget _textField() {
    return TextField(
      controller: _controller,
      maxLines: 1,
      style: AppTextStyles.body16,
      cursorColor: AppColors.accent,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => _send(),
      decoration: const InputDecoration.collapsed(
        hintText: AppStrings.messageHint,
        hintStyle: AppTextStyles.placeholder,
      ),
    );
  }
}

/// Large glowing mic button shown while recording a voice message.
class _RecordMicButton extends StatelessWidget {
  const _RecordMicButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accent,
        boxShadow: [
          // Soft outer glow.
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.6),
            blurRadius: 60,
          ),
          // 10px ring around the circle.
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.2),
            spreadRadius: 10,
          ),
        ],
      ),
      child: const Center(
        child: AppImage(
          AppAssets.icMic,
          width: 32,
          height: 32,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.color,
    required this.child,
    required this.onTap,
    this.glow,
  });

  final Color color;
  final Widget child;
  final VoidCallback onTap;
  final List<BoxShadow>? glow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: glow,
        ),
        child: Center(child: child),
      ),
    );
  }
}
