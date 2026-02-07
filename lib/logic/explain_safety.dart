// explain_safety.dart
// Uses templates to generate explanations

import 'prompt_templates.dart';

String explainSafety(Map<String, dynamic> payload) {
  // --------------------
  // OVERALL / GENERAL QUESTIONS
  // --------------------
  if (payload["type"] == "OVERALL") {
    final int score = payload["safetyScore"];

    if (score >= 75) {
      return "Ghar ki sthiti kaafi had tak surakshit hai.";
    }

    if (score >= 45) {
      return "Ghar ki sthiti theek hai, lekin kuch jagah dabav dikh raha hai.";
    }

    return "Ghar ki financial sthiti kamzor hai aur risk zyada hai.";
  }

  // --------------------
  // DOMAIN‑SPECIFIC
  // --------------------
  final String domain = payload["domain"];
  final String status = payload["status"];

  return templates[domain]?[status] ?? "";
}
