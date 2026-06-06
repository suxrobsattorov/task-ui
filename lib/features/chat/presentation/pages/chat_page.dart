import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
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

class _ChatPageState extends State<ChatPage> {
  late final ChatController _controller = ChatController(
    firstMessage: widget.firstMessage,
  );

  @override
  void dispose() {
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
                        padding: const EdgeInsets.fromLTRB(20, 70, 20, 12),
                        itemCount: _controller.messages.length,
                        separatorBuilder: (_, _) => const Gap(AppSpacing.s12),
                        itemBuilder: (_, i) =>
                            _buildMessage(_controller.messages[i]),
                      ),
                    ),
                    Positioned(top: 10, child: LicensePlate()),
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
