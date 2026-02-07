// risk_classifier.dart
// Converts family answers into risk states + reasons

class RiskReason {
  final String code;
  final String severity;

  RiskReason({
    required this.code,
    required this.severity,
  });
}

class RiskResult {
  final Map<String, String> risks;
  final List<RiskReason> reasons;

  RiskResult({
    required this.risks,
    required this.reasons,
  });
}

RiskResult classifyRisks(Map<String, dynamic> family) {
  final Map<String, String> risks = {};
  final List<RiskReason> reasons = [];

  // -------------------------
  // Income stability
  // -------------------------
  if (family["earners"] == 1) {
    risks["income"] = "fragile";
    reasons.add(
      RiskReason(
        code: "SINGLE_INCOME",
        severity: "high",
      ),
    );
  } else {
    risks["income"] = "stable";
  }

  // -------------------------
  // Medical protection
  // -------------------------
  if (family["medicalCovered"] != true) {
    risks["medical"] = "not_covered";
    reasons.add(
      RiskReason(
        code: "NO_MEDICAL_COVER",
        severity: "high",
      ),
    );
  } else {
    risks["medical"] = "covered";
  }

  // -------------------------
  // Education continuity
  // -------------------------
  if (family["childrenInSchool"] != true) {
    risks["education"] = "broken";
    reasons.add(
      RiskReason(
        code: "EDUCATION_STOPPED",
        severity: "high",
      ),
    );
  } else if (family["feeDelays"] == true ||
      family["educationSavings"] != true) {
    risks["education"] = "at_risk";
    reasons.add(
      RiskReason(
        code: "EDUCATION_AT_RISK",
        severity: "medium",
      ),
    );
  } else {
    risks["education"] = "stable";
  }

  // -------------------------
  // Emergency + Safety Shield
  // -------------------------
  if (family["emergencyShieldActive"] == true) {
    risks["emergencyFund"] = "strong";
  } else if (family["hasEmergencySavings"] != true &&
      family["hasSupportNetwork"] != true) {
    risks["emergencyFund"] = "missing";
    reasons.add(
      RiskReason(
        code: "NO_EMERGENCY_SUPPORT",
        severity: "high",
      ),
    );
  } else if (family["hasEmergencySavings"] != true) {
    risks["emergencyFund"] = "weak";
    reasons.add(
      RiskReason(
        code: "WEAK_EMERGENCY_SUPPORT",
        severity: "medium",
      ),
    );
  } else {
    risks["emergencyFund"] = "strong";
  }

  return RiskResult(
    risks: risks,
    reasons: reasons,
  );
}
