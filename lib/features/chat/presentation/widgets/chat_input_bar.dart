import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_durations.dart';
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

class _ChatInputBarState extends State<ChatInputBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  // Drives the press-to-record morph: 0 = idle mic (40px), 1 = recording
  // mic (80px glowing). Grows with a slight overshoot on press and eases
  // back on release, like the Figma prototype.
  late final AnimationController _recordCtrl = AnimationController(
    vsync: this,
    duration: AppDurations.normal,
    reverseDuration: AppDurations.fast,
    value: widget.recording ? 1 : 0,
  );
  late final Animation<double> _t = CurvedAnimation(
    parent: _recordCtrl,
    curve: Curves.easeOutBack,
    reverseCurve: Curves.easeInCubic,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void didUpdateWidget(covariant ChatInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recording != oldWidget.recording) {
      widget.recording ? _recordCtrl.forward() : _recordCtrl.reverse();
    }
  }

  @override
  void dispose() {
    _recordCtrl.dispose();
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
        // The whole bar rebuilds each frame of the record morph. The mic's
        // Listener stays mounted throughout, so a press that started the
        // recording still receives its release while the button is grown.
        child: AnimatedBuilder(
          animation: _t,
          builder: (context, _) {
            final t = _t.value;
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _leftPill(t),
                _hasText ? _sendButton() : _micButton(t),
              ],
            );
          },
        ),
      ),
    );
  }

  // Left side of the bar: the text field cross-fades into the recording pill
  // (dot + timer) as recording ramps up.
  Widget _leftPill(double t) {
    final ct = t.clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // Full-width recording pill, fades in. Also sets the row's size.
          Opacity(opacity: ct, child: _recordingPill()),
          // Text field, fades out; leaves 52px on the right for the mic.
          Positioned.fill(
            right: 52,
            child: Opacity(
              opacity: 1 - ct,
              child: IgnorePointer(
                ignoring: t > 0,
                child: _pill(child: _textField()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Press and hold to record, release to send (Telegram-style). The same
  /// button grows into the big glowing recording mic via [_micMorph].
  Widget _micButton(double t) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 20,
      child: Center(
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) {
            FocusScope.of(context).unfocus();
            widget.onStartRecording();
          },
          onPointerUp: (_) => widget.onStopRecording(),
          onPointerCancel: (_) => widget.onCancelRecording(),
          child: _micMorph(t),
        ),
      ),
    );
  }

  // A single 40px mic that morphs into the 80px recording mic as [t] 0->1:
  // the circle scales about its center (idle and recording mics share the
  // same center, so no repositioning), darkens into accent with a glow, and
  // the icon grows 24->32 and turns white. The icon is overlaid rather than
  // scaled with the circle so it tracks the Figma 24->32 step, not 24->48.
  Widget _micMorph(double t) {
    final ct = t.clamp(0.0, 1.0);
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.scale(
            scale: 1 + t,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.lerp(const Color(0xFF1E2430), AppColors.accent, ct)!,
                    Color.lerp(const Color(0xFF1A1E26), AppColors.accent, ct)!,
                  ],
                ),
                // Glow fades in; blur/spread are halved because Transform.scale
                // doubles them at full size (-> 60 blur, 10px ring, as Figma).
                boxShadow: t <= 0
                    ? null
                    : [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.6 * ct),
                          blurRadius: 30,
                        ),
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.2 * ct),
                          spreadRadius: 5,
                        ),
                      ],
              ),
            ),
          ),
          AppImage(
            AppAssets.icMic,
            width: 24 + 8 * ct,
            height: 24 + 8 * ct,
            color: Color.lerp(AppColors.textMuted, AppColors.white, ct),
          ),
        ],
      ),
    );
  }

  Widget _sendButton() {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 20,
      child: Center(
        child: _CircleButton(
          color: AppColors.accent,
          glow: AppShadows.accentGlow,
          onTap: _send,
          child: const AppImage(AppAssets.icSend, width: 24, height: 24),
        ),
      ),
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
