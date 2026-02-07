// rules.dart
// Core scoring constants
// Pure configuration — no logic

class SafetyRules {
  static const int baseScore = 100;

  // Income
  static const int incomePenalty = 15;

  // Medical
  static const int medicalPenalty = 20;

  // Education
  static const int educationRiskPenalty = 10;
  static const int educationBrokenPenalty = 25;

  // Emergency fund
  static const int emergencyWeakPenalty = 15;
  static const int emergencyMissingPenalty = 30;
}
