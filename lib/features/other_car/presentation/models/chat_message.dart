enum ChatAuthor { me, other }

sealed class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.author,
    required this.time,
  });

  final String id;
  final ChatAuthor author;
  final String time;
}

class TextMessage extends ChatMessage {
  const TextMessage({
    required super.id,
    required super.author,
    required super.time,
    required this.text,
  });

  final String text;
}

class VoiceMessage extends ChatMessage {
  const VoiceMessage({
    required super.id,
    required super.author,
    required super.time,
    required this.duration,
  });

  final String duration;
}
