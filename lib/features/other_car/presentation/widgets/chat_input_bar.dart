import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';

/// Bottom message bar with three states: idle (mic), typing (send) and
/// recording (live timer + glowing mic).
class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.recording,
    required this.onSend,
    required this.onStartRecording,
    required this.onStopRecording,
  });

  final bool recording;
  final ValueChanged<String> onSend;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;

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
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: SafeArea(
        top: false,
        child: widget.recording ? _recordingRow() : _normalRow(),
      ),
    );
  }

  Widget _normalRow() {
    return Row(
      children: [
        Expanded(child: _pill(child: _textField())),
        const SizedBox(width: 12),
        _hasText
            ? _CircleButton(
                color: AppColors.accent,
                glow: AppShadows.accentGlow,
                onTap: _send,
                child: const AppImage(AppAssets.icSend, width: 24, height: 24),
              )
            : _MicButton(onTap: widget.onStartRecording),
      ],
    );
  }

  Widget _recordingRow() {
    return Row(
      children: [
        Expanded(
          child: _pill(
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('0:03', style: AppTextStyles.body16),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _CircleButton(
          color: AppColors.accent,
          glow: AppShadows.accentGlow,
          onTap: widget.onStopRecording,
          child: const AppImage(
            AppAssets.icMic,
            width: 24,
            height: 24,
            color: AppColors.bg,
          ),
        ),
      ],
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

class _MicButton extends StatelessWidget {
  const _MicButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
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
