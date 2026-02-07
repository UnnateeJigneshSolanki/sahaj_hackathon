import 'package:flutter/services.dart';

class SpeechService {
  static const _channel = MethodChannel('speech_to_text');

  static Future<String?> listen() async {
    final result = await _channel.invokeMethod<String>('startListening');
    return result;
  }
}
