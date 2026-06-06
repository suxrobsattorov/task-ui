import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

import '../../../../core/constants/app_strings.dart';
import '../models/chat_message.dart';

class ChatController extends ChangeNotifier {
  ChatController({String? firstMessage}) {
    final first = firstMessage?.trim();
    if (first != null && first.isNotEmpty) {
      _messages.add(
        TextMessage(
          id: _nextId(),
          author: ChatAuthor.me,
          time: _now(),
          text: first,
        ),
      );
    }
    // The only pre-existing message in the chat: a single reply from the owner.
    _messages.add(
      TextMessage(
        id: _nextId(),
        author: ChatAuthor.other,
        time: _now(),
        text: AppStrings.reply,
      ),
    );

    _player.onPlayerComplete.listen((_) => _resetPlayback());
    _player.onPositionChanged.listen((pos) {
      if (_playingId == null) return;
      _playPosition = pos;
      notifyListeners();
    });
    _player.onDurationChanged.listen((dur) {
      _playDuration = dur;
      notifyListeners();
    });
  }

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  bool _recording = false;
  bool get recording => _recording;

  Duration _recordElapsed = Duration.zero;
  String get recordingTime => _fmt(_recordElapsed);
  Timer? _ticker;
  DateTime? _recordStart;
  bool _busy = false;
  bool _pendingStop = false;

  String? _playingId;
  Duration _playPosition = Duration.zero;
  Duration _playDuration = Duration.zero;

  int _seq = 0;
  String _nextId() => 'm${++_seq}';

  bool isPlaying(String id) => _playingId == id;

  /// Playback progress (0..1) of the currently playing voice message.
  double playProgress(String id) {
    if (_playingId != id || _playDuration.inMilliseconds == 0) return 0;
    return (_playPosition.inMilliseconds / _playDuration.inMilliseconds).clamp(
      0.0,
      1.0,
    );
  }

  /// Elapsed position while playing, otherwise the full recorded duration.
  String playLabel(VoiceMessage m) =>
      _playingId == m.id ? _fmt(_playPosition) : m.duration;

  void sendText(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    _messages.add(
      TextMessage(
        id: _nextId(),
        author: ChatAuthor.me,
        time: _now(),
        text: trimmed,
      ),
    );
    notifyListeners();
  }

  Future<void> startRecording() async {
    if (_recording || _busy) return;
    _busy = true;
    try {
      if (!await _recorder.hasPermission()) {
        debugPrint('startRecording: microphone permission denied');
        return;
      }
      final dir = Directory.systemTemp;
      final path =
          '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      debugPrint('startRecording: recording to $path');
      _recording = true;
      _recordStart = DateTime.now();
      _recordElapsed = Duration.zero;
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        _recordElapsed += const Duration(seconds: 1);
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      debugPrint('startRecording failed: $e');
      _ticker?.cancel();
      _recording = false;
      _recordElapsed = Duration.zero;
      notifyListeners();
    } finally {
      _busy = false;
      if (_pendingStop) {
        _pendingStop = false;
        await stopAndSendVoice();
      }
    }
  }

  Future<void> cancelRecording() async {
    if (!_recording) return;
    _ticker?.cancel();
    _recording = false;
    _recordElapsed = Duration.zero;
    try {
      await _recorder.cancel();
    } catch (e) {
      debugPrint('cancelRecording failed: $e');
    }
    notifyListeners();
  }

  Future<void> stopAndSendVoice() async {
    if (_busy) {
      _pendingStop = true;
      return;
    }
    if (!_recording) return;
    _ticker?.cancel();
    final start = _recordStart;
    final elapsed = start == null
        ? Duration.zero
        : DateTime.now().difference(start);
    _recording = false;
    _recordElapsed = Duration.zero;
    _recordStart = null;
    try {
      final path = await _recorder.stop();
      debugPrint(
        'stopAndSendVoice: path=$path elapsed=${elapsed.inMilliseconds}ms',
      );
      if (path != null && elapsed.inMilliseconds >= 300) {
        _messages.add(
          VoiceMessage(
            id: _nextId(),
            author: ChatAuthor.me,
            time: _now(),
            duration: _fmt(elapsed),
            path: path,
          ),
        );
      }
    } catch (e) {
      debugPrint('stopAndSendVoice failed: $e');
    }
    notifyListeners();
  }

  Future<void> togglePlay(VoiceMessage m) async {
    try {
      if (_playingId == m.id) {
        await _player.stop();
        _resetPlayback();
        return;
      }
      await _player.stop();
      _playingId = m.id;
      _playPosition = Duration.zero;
      _playDuration = Duration.zero;
      notifyListeners();
      await _player.play(DeviceFileSource(m.path));
    } catch (e) {
      debugPrint('togglePlay failed: $e');
      _resetPlayback();
    }
  }

  void _resetPlayback() {
    _playingId = null;
    _playPosition = Duration.zero;
    _playDuration = Duration.zero;
    notifyListeners();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes;
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _now() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }
}
