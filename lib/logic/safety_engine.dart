// safety_engine.dart
// Calculates safety score and safety state from risks

import 'rules.dart';

class SafetyResult {
  final int safetyScore;
  final String safetyState; // "safe" | "stressed" | "vulnerable"

  SafetyResult({
    required this.safetyScore,
    required this.safetyState,
  });
}

SafetyResult calculateSafetyScore(Map<String, String> risks) {
  int score = SafetyRules.baseScore;

  // --------------------
  // INCOME
  // --------------------
  if (risks["income"] == "fragile") {
    score -= SafetyRules.incomePenalty;
  }

  // --------------------
  // MEDICAL
  // --------------------
  if (risks["medical"] == "not_covered") {
    score -= SafetyRules.medicalPenalty;
  }

  // --------------------
  // EDUCATION
  // --------------------
  if (risks["education"] == "at_risk") {
    score -= SafetyRules.educationRiskPenalty;
  }

  if (risks["education"] == "broken") {
    score -= SafetyRules.educationBrokenPenalty;
  }

  // --------------------
  // EMERGENCY PROTECTION FUND
  // --------------------
  if (risks["emergencyFund"] == "weak") {
    score -= SafetyRules.emergencyWeakPenalty;
  }

  if (risks["emergencyFund"] == "missing") {
    score -= SafetyRules.emergencyMissingPenalty;
  }

  // --------------------
  // CLAMP SCORE (0–100)
  // --------------------
  if (score < 0) score = 0;
  if (score > 100) score = 100;

  // --------------------
  // SAFETY STATE
  // --------------------
  String safetyState = "safe";

  if (score < 70) safetyState = "stressed";
  if (score < 40) safetyState = "vulnerable";

  return SafetyResult(
    safetyScore: score,
    safetyState: safetyState,
  );
}
