// questions_engine.dart
import 'questions.dart';

class QuestionResult {
  final Map<String, dynamic> familyAnswers;
  final Question? nextQuestion;

  QuestionResult({required this.familyAnswers, required this.nextQuestion});
}

class QuestionsEngine {
  final Map<String, dynamic> familyAnswers;
  int _currentIndex = 0;
  String _language;

  QuestionsEngine({
    required this.familyAnswers,
    String initialLanguage = "hindi",
  }) : _language = initialLanguage;

  // -------------------------
  // QUESTION ACCESS
  // -------------------------
  Question? getNextQuestion() {
    if (_currentIndex >= QUESTIONS.length) return null;
    return QUESTIONS[_currentIndex];
  }

  // -------------------------
  // RECORD ANSWER
  // -------------------------
 QuestionResult recordAnswer(dynamic answer) {
  if (_currentIndex < QUESTIONS.length) {
    final current = QUESTIONS[_currentIndex];
    familyAnswers[current.key] = answer;

    // 🔥 ADD THESE DEFAULTS (VERY IMPORTANT)
    familyAnswers.putIfAbsent("earners", () => 1);
    familyAnswers.putIfAbsent("medicalCovered", () => false);
    familyAnswers.putIfAbsent("childrenInSchool", () => true);
    familyAnswers.putIfAbsent("feeDelays", () => false);
    familyAnswers.putIfAbsent("educationSavings", () => false);
    familyAnswers.putIfAbsent("emergencyShieldActive", () => false);
    familyAnswers.putIfAbsent("hasEmergencySavings", () => false);
    familyAnswers.putIfAbsent("hasSupportNetwork", () => false);

    _currentIndex++;
  }

  return QuestionResult(
    familyAnswers: familyAnswers,
    nextQuestion: getNextQuestion(),
  );
}

  // -------------------------
  // LANGUAGE CONTROL
  // -------------------------
  void setLanguage(String lang) {
    if (lang == "hindi" || lang == "hinglish") {
      _language = lang;
    }
  }

  String getQuestionText(Question q) {
    return q.question[_language] ?? q.question["hindi"]!;
  }

  // -------------------------
  // ENGINE MESSAGES
  // -------------------------
  String getEngineMessage(String type) {
    const messages = {
      "NEED_INFO": {
        "hinglish": "Pehle ghar ki sthiti se judi kuch jaankari chahiye.",
        "hindi": "पहले घर की स्थिति से जुड़ी कुछ जानकारी आवश्यक है।",
      },
      "COMPLETED": {
        "hinglish": "Aapne sabhi sawalon ke jawab de diye hain.",
        "hindi": "आपने सभी प्रश्नों के उत्तर दे दिए हैं।",
      },
    };

    return messages[type]?[_language] ?? "";
  }

  // -------------------------
  // RESET
  // -------------------------
  void reset() {
    _currentIndex = 0;
  }
}
