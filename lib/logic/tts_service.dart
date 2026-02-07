// tts_service.dart
// Handles text → speech (slow, clear Hindi voice)

import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  bool _isConfigured = false;

  Future<void> init() async {
    if (_isConfigured) return;

    await _tts.setLanguage("hi-IN");
    await _tts.setSpeechRate(0.45); // slower = better clarity
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    _isConfigured = true;
  }

  Future<void> speak(String text) async {
    await init();
    await _tts.stop(); // stop any previous speech
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
