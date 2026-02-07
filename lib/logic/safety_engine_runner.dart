// safety_engine_runner.dart
// Orchestrates risk classification + safety scoring

import 'risk_classifier.dart';
import 'safety_engine.dart';

class SafetyEngineOutput {
  final int safetyScore;
  final String safetyState;
  final Map<String, String> risks;

  SafetyEngineOutput({
    required this.safetyScore,
    required this.safetyState,
    required this.risks,
  });
}

SafetyEngineOutput runSafetyEngine(Map<String, dynamic> familyInput) {
  // --------------------
  // STEP 1: CLASSIFY RISKS
  // --------------------
  final RiskResult riskResult = classifyRisks(familyInput);
  final Map<String, String> risks = riskResult.risks;

  /*
    Expected risks shape:
    {
      income: "stable" | "fragile",
      medical: "covered" | "not_covered",
      education: "stable" | "at_risk" | "broken",
      emergencyFund: "strong" | "weak" | "missing"
    }
  */

  // --------------------
  // STEP 2: CALCULATE SCORE
  // --------------------
  final SafetyResult safetyResult = calculateSafetyScore(risks);

  // --------------------
  // STEP 3: RETURN SINGLE TRUTH OBJECT
  // --------------------
  return SafetyEngineOutput(
    safetyScore: safetyResult.safetyScore,
    safetyState: safetyResult.safetyState,
    risks: risks,
  );
}
