// nudge_engine.dart
// Generates nudges based on user action + current risk state

List<String> generateNudges(
  String actionKey,
  Map<String, dynamic> engineOutput,
) {
  final List<String> nudges = [];
  final Map<String, String> risks = Map<String, String>.from(
    engineOutput["risks"],
  );

  // -------------------------
  // Positive reinforcement
  // -------------------------
  if (actionKey == "SAVE_SMALL") {
    if (risks["emergencyFund"] != "strong") {
      nudges.add("Chhoti bachat emergency shield ko majboot banati hai.");
    }

    if (risks["education"] == "at_risk") {
      nudges.add("Aaj ki bachat aage padhai ke risk ko kam kar sakti hai.");
    }
  }

  // -------------------------
  // Negative pressure explanation
  // -------------------------
  if (actionKey == "SPEND_NON_ESSENTIAL") {
    nudges.add("Yeh kharcha family safety par dabav daal sakta hai.");
  }

  if (actionKey == "SKIP_SAVING") {
    nudges.add("Aaj bachat nahi hui, emergency taiyari aage nahi badhi.");
  }

  return nudges;
}
