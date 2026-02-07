import 'package:flutter/material.dart';
import '../logic/sahaj_controller.dart';
import '../logic/questions.dart';
import '../voice/tts_service.dart';
import 'safety_status_screen.dart';

class GharKiSthitiScreen extends StatefulWidget {
  final SahajController controller;
  final String userName;

  const GharKiSthitiScreen({
    super.key,
    required this.controller,
    required this.userName,
  });

  @override
  State<GharKiSthitiScreen> createState() => _GharKiSthitiScreenState();
}

class _GharKiSthitiScreenState extends State<GharKiSthitiScreen> {
  Question? currentQuestion;
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();

    // 🔥 MOST IMPORTANT
    TtsService.init();

    currentQuestion = widget.controller.getNextQuestion();
  }

  @override
  void dispose() {
    TtsService.stop();
    super.dispose();
  }

  void handleAnswer(dynamic answer) {
    // 🔕 stop voice before moving ahead
    TtsService.stop();

    final next = widget.controller.recordAnswer(answer);

    if (next == null) {
      setState(() => isCompleted = true);
      return;
    }

    setState(() {
      currentQuestion = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final String questionText =
        currentQuestion!.question['hindi']?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('नमस्ते ${widget.userName}'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.orange),
                onPressed: () {
                  if (questionText.isNotEmpty) {
                    TtsService.speak(questionText);
                  }
                },
              ),
            ),

            const SizedBox(height: 24),

            if (currentQuestion!.type == 'BOOLEAN') ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => handleAnswer(true),
                      child: const Text('हाँ'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => handleAnswer(false),
                      child: const Text('नहीं'),
                    ),
                  ),
                ],
              ),
            ],

            if (currentQuestion!.type == 'NUMBER') ...[
              ...(currentQuestion!.options ?? []).map(
                (opt) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => handleAnswer(opt),
                      child: Text(opt.toString()),
                    ),
                  ),
                ),
              ),
            ],

            if (isCompleted) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SafetyStatusScreen(
                          controller: widget.controller,
                          userName: widget.userName,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'आगे बढ़ें',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
