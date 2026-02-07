// savings_impact_engine.dart
// Evaluates how a savings action impacts future safety

class SavingsImpact {
  final String type; // positive | negative | warning
  final String message;

  SavingsImpact({required this.type, required this.message});
}

List<SavingsImpact> evaluateSavingsImpact(
  String action,
  Map<String, dynamic> engineOutput,
) {
  final List<SavingsImpact> impacts = [];
  final Map<String, String> risks = Map<String, String>.from(
    engineOutput["risks"],
  );

  // -------------------------
  // Emergency buffer logic
  // -------------------------
  if (action == "SAVE_SMALL") {
    if (risks["emergencyFund"] != "strong") {
      impacts.add(
        SavingsImpact(
          type: "positive",
          message: "Saving thoda‑thoda emergency shield ko majboot banata hai.",
        ),
      );
    }

    if (risks["education"] == "at_risk") {
      impacts.add(
        SavingsImpact(
          type: "positive",
          message:
              "Aaj ki chhoti bachat aage padhai ka risk kam kar sakti hai.",
        ),
      );
    }
  }

  if (action == "SPEND_NON_ESSENTIAL") {
    if (risks["emergencyFund"] != "strong") {
      impacts.add(
        SavingsImpact(
          type: "negative",
          message: "Yeh kharcha emergency safety ko kamzor karta hai.",
        ),
      );
    }
  }

  if (action == "SKIP_SAVING") {
    impacts.add(
      SavingsImpact(
        type: "warning",
        message: "Aaj bachat nahi hui, emergency taiyari ruk gayi hai.",
      ),
    );
  }

  return impacts;
}
