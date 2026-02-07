import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final FlutterTts _tts = FlutterTts();

  static bool _initialized = false;
  static bool _speaking = false;

  static Future<void> init() async {
    if (_initialized) return;

    await _tts.setLanguage('hi-IN');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    // 🔥 Android stability
    await _tts.awaitSpeakCompletion(false);
    await _tts.setSharedInstance(true);

    _tts.setStartHandler(() {
      _speaking = true;
    });

    _tts.setCompletionHandler(() {
      _speaking = false;
    });

    _tts.setErrorHandler((msg) {
      _speaking = false;
      debugPrint('TTS ERROR: $msg');
    });

    _initialized = true;
  }

  static Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;

    try {
      await init();

      if (_speaking) {
        await _tts.stop();
        await Future.delayed(const Duration(milliseconds: 200));
      }

      await _tts.speak(text);
    } catch (e) {
      debugPrint('TTS SPEAK FAILED: $e');
    }
  }

  static Future<void> stop() async {
    if (_speaking) {
      await _tts.stop();
      _speaking = false;
    }
  }
}
