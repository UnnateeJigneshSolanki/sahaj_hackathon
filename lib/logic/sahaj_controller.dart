// sahaj_controller.dart

import 'questions_engine.dart';
import 'questions.dart';
import 'safety_engine_runner.dart';

class SahajController {
  final Map<String, dynamic> _familyAnswers = {};
  late final QuestionsEngine _questionsEngine;

  SafetyEngineOutput? _engineOutput;

  SahajController() {
    // 🔥 IMPORTANT: SAME MAP PASSED
    _questionsEngine =
        QuestionsEngine(familyAnswers: _familyAnswers);
  }

  // -----------------------------
  // QUESTIONS FLOW
  // -----------------------------
  Question? getNextQuestion() {
    return _questionsEngine.getNextQuestion();
  }

 Question? recordAnswer(dynamic answer) {
  _questionsEngine.recordAnswer(answer);

  // 🔥 NORMALIZE ANSWERS FOR RISK ENGINE
  _familyAnswers["earners"] =
      int.tryParse(_familyAnswers["earningMembers"]?.toString() ?? "1") ?? 1;

  _familyAnswers["medicalCovered"] =
      _familyAnswers["medicalCovered"] == true;

  _familyAnswers["childrenInSchool"] =
      _familyAnswers["childrenInSchool"] == true;

  _familyAnswers["feeDelays"] =
      _familyAnswers["educationWorry"] == true;

  _familyAnswers["educationSavings"] =
      _familyAnswers["educationWorry"] != true;

  _familyAnswers["hasEmergencySavings"] =
      _familyAnswers["emergencySavingsActive"] == true;

  _familyAnswers["emergencyShieldActive"] = false; // future use

  // 🔥 NOW engine gets correct data
  _engineOutput = runSafetyEngine(_familyAnswers);

  return _questionsEngine.getNextQuestion();
}


  // -----------------------------
  // SAFETY STATUS
  // -----------------------------
  Map<String, dynamic> getSafetyStatus() {
    if (_engineOutput == null) {
      return {
        "ready": false,
        "message": _questionsEngine.getEngineMessage("NEED_INFO"),
      };
    }

    return {
      "ready": true,
      "score": _engineOutput!.safetyScore,
      "state": _engineOutput!.safetyState,
      "risks": _engineOutput!.risks,
    };
  }
}
