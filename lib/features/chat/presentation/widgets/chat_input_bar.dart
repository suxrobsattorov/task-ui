import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
      child: SafeArea(
        top: false,
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

  Widget _leftPill(double t) {
    final ct = t.clamp(0.0, 1.0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        children: [
          Opacity(opacity: ct, child: _recordingPill()),
          Positioned.fill(
            right: 52.w,
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

  Widget _micButton(double t) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 20.w,
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

  Widget _micMorph(double t) {
    final ct = t.clamp(0.0, 1.0);
    return SizedBox(
      width: 40.r,
      height: 40.r,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.scale(
            scale: 1 + t,
            child: Container(
              width: 40.r,
              height: 40.r,
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
            width: (24 + 8 * ct).r,
            height: (24 + 8 * ct).r,
            color: Color.lerp(AppColors.white, AppColors.bg, ct),
          ),
        ],
      ),
    );
  }

  Widget _sendButton() {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 20.w,
      child: Center(
        child: _CircleButton(
          color: AppColors.accent,
          glow: AppShadows.accentGlow,
          onTap: _send,
          child: AppImage(AppAssets.icSend, width: 24.r, height: 24.r),
        ),
      ),
    );
  }

  Widget _recordingPill() {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1E2430), Color(0xFF1A1E26)],
        ),
      ),
      padding: const EdgeInsets.all(1),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(19.r)),
          color: AppColors.bg,
        ),
        child: Row(
          children: [
            Container(
              width: 12.r,
              height: 12.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
            ),
            SizedBox(width: 12.w),
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
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
      decoration: InputDecoration.collapsed(
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
        width: 40.r,
        height: 40.r,
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
