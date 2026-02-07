// domain_status_mapper.dart
// Maps risk states to simple domain status (good / bad)

Map<String, String> getDomainStatus(Map<String, String> risks) {
  return {
    "EDUCATION": risks["education"] == "stable" ? "good" : "bad",
    "MEDICAL": risks["medical"] == "covered" ? "good" : "bad",
    "EMERGENCY": risks["emergencyFund"] == "strong" ? "good" : "bad",
    "INCOME": risks["income"] == "stable" ? "good" : "bad",
  };
}
