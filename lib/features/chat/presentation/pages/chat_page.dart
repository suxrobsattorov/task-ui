import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_durations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/license_plate.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/voice_message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.firstMessage});

  final String? firstMessage;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  late final ChatController _controller = ChatController(
    firstMessage: widget.firstMessage,
  );
  final ScrollController _scrollController = ScrollController();
  int _messageCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _messageCount = _controller.messages.length;
    _controller.addListener(_onControllerChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToBottom());
  }

  void _onControllerChanged() {
    final count = _controller.messages.length;
    if (count == _messageCount) return;
    _messageCount = count;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _jumpToBottom());
  }

  void _jumpToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: AppDurations.normal,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onControllerChanged);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(title: AppStrings.chatTitle),
              Expanded(
                child: Stack(
                  alignment: AlignmentGeometry.topCenter,
                  children: [
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) => ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 12.h),
                        itemCount: _controller.messages.length,
                        separatorBuilder: (_, _) => const Gap(AppSpacing.s12),
                        itemBuilder: (_, i) =>
                            _buildMessage(_controller.messages[i]),
                      ),
                    ),
                    Positioned(top: 10.h, child: const LicensePlate()),
                  ],
                ),
              ),
              ListenableBuilder(
                listenable: _controller,
                builder: (context, _) => ChatInputBar(
                  recording: _controller.recording,
                  recordingLabel: _controller.recordingTime,
                  onSend: _controller.sendText,
                  onStartRecording: _controller.startRecording,
                  onStopRecording: _controller.stopAndSendVoice,
                  onCancelRecording: _controller.cancelRecording,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(ChatMessage m) => switch (m) {
    TextMessage() => ChatBubble(message: m),
    VoiceMessage() => VoiceMessageBubble(
      message: m,
      playing: _controller.isPlaying(m.id),
      progress: _controller.playProgress(m.id),
      label: _controller.playLabel(m),
      onPlayToggle: () => _controller.togglePlay(m),
    ),
  };
}
