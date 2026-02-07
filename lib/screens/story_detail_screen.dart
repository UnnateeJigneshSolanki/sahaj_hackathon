import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/learning_stories.dart';

class StoryDetailScreen extends StatefulWidget {
  final LearningStory story;

  const StoryDetailScreen({super.key, required this.story});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final FlutterTts _tts = FlutterTts();
  bool isSpeaking = false;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setLanguage('hi-IN');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);

    _tts.setErrorHandler((msg) {
      if (!mounted) return;
      setState(() => isSpeaking = false);
    });

    setState(() => isReady = true);
  }

  Future<void> _readAloud() async {
    if (!isReady) return;

    if (isSpeaking) {
      await _tts.stop();
      setState(() => isSpeaking = false);
      return;
    }

    setState(() => isSpeaking = true);

    try {
      await _tts.stop();
      await Future.delayed(const Duration(milliseconds: 300));
      await _tts.speak(widget.story.hindi);
    } catch (_) {
      setState(() => isSpeaking = false);
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EE),
      appBar: AppBar(
        title: Text(widget.story.title),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _storyBox('📜 शुद्ध हिंदी', widget.story.hindi),
            const SizedBox(height: 20),
            _storyBox('🗣️ Hinglish', widget.story.hinglish),
            const SizedBox(height: 90),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: _readAloud,
        icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
        label: Text(isSpeaking ? 'रोकें' : 'सुनो'),
      ),
    );
  }

  Widget _storyBox(String title, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
