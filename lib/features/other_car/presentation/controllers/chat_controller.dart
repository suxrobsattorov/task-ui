import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_strings.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  ChatController({String? firstMessage}) {
    _messages.add(
      TextMessage(
        id: 'm1',
        author: ChatAuthor.me,
        time: '19:40',
        text: firstMessage ?? AppStrings.notifications.first,
      ),
    );
    _messages.addAll(const [
      VoiceMessage(
        id: 'm2',
        author: ChatAuthor.me,
        time: '19:40',
        duration: '0:03',
      ),
      TextMessage(
        id: 'm3',
        author: ChatAuthor.me,
        time: '19:45',
        text: AppStrings.quickReply,
      ),
      TextMessage(
        id: 'm4',
        author: ChatAuthor.other,
        time: '19:46',
        text: AppStrings.reply,
      ),
    ]);
  }

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  bool _recording = false;
  bool get recording => _recording;

  String? _playingId;
  bool isPlaying(String id) => _playingId == id;

  int _seq = 5;

  void sendText(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _messages.add(
      TextMessage(
        id: 'm${_seq++}',
        author: ChatAuthor.me,
        time: '19:46',
        text: trimmed,
      ),
    );
    notifyListeners();
  }

  void startRecording() {
    _recording = true;
    notifyListeners();
  }

  void cancelRecording() {
    _recording = false;
    notifyListeners();
  }

  void stopAndSendVoice() {
    _recording = false;
    _messages.add(
      VoiceMessage(
        id: 'm${_seq++}',
        author: ChatAuthor.me,
        time: '19:46',
        duration: '0:03',
      ),
    );
    notifyListeners();
  }

  void togglePlay(String id) {
    _playingId = _playingId == id ? null : id;
    notifyListeners();
  }
}
