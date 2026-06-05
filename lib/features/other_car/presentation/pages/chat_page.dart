import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/gap.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/license_plate.dart';
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
              const Gap(AppSpacing.s16),
              const Center(child: LicensePlate()),
              const Gap(AppSpacing.s24),
              Expanded(
                child: ListenableBuilder(
                  listenable: _controller,
                  builder: (context, _) => ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    itemCount: _controller.messages.length,
                    separatorBuilder: (_, _) => const Gap(AppSpacing.s12),
                    itemBuilder: (_, i) =>
                        _buildMessage(_controller.messages[i]),
                  ),
                ),
              ),
              ListenableBuilder(
                listenable: _controller,
                builder: (context, _) => ChatInputBar(
                  recording: _controller.recording,
                  onSend: _controller.sendText,
                  onStartRecording: _controller.startRecording,
                  onStopRecording: _controller.stopAndSendVoice,
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
      onPlayToggle: () => _controller.togglePlay(m.id),
    ),
  };
}
