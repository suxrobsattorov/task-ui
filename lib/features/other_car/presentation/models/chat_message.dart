/// Who sent a chat message.
enum ChatAuthor { me, other }

/// Base type for a chat message. Sealed so the UI can pattern-match exhaustively.
sealed class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.author,
    required this.time,
  });

  final String id;
  final ChatAuthor author;
  final String time; // pre-formatted "HH:mm"
}

/// A plain text bubble.
class TextMessage extends ChatMessage {
  const TextMessage({
    required super.id,
    required super.author,
    required super.time,
    required this.text,
  });

  final String text;
}

/// A voice message bubble (play button + waveform + duration).
class VoiceMessage extends ChatMessage {
  const VoiceMessage({
    required super.id,
    required super.author,
    required super.time,
    required this.duration,
  });

  final String duration; // "0:03"
}
