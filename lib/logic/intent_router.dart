// intent_router.dart
// Domain detection using Hindi + Hinglish keywords (regex based)

String detectDomain(String? text) {
  if (text == null || text.trim().isEmpty) {
    return "GENERAL";
  }

  final String t = text.toLowerCase();

  // --------------------
  // EDUCATION
  // --------------------
  final educationRegex = RegExp(
    r'पढ़ाई|पढाई|स्कूल|शिक्षा|padhai|school|study|padhna',
  );

  if (educationRegex.hasMatch(t)) {
    return "EDUCATION";
  }

  // --------------------
  // MEDICAL
  // --------------------
  final medicalRegex = RegExp(
    r'बीमारी|इलाज|दवा|अस्पताल|bimari|hospital|dawai|ill',
  );

  if (medicalRegex.hasMatch(t)) {
    return "MEDICAL";
  }

  // --------------------
  // EMERGENCY / SAVINGS
  // --------------------
  final emergencyRegex = RegExp(
    r'आपात|emergency|अचानक|मुसीबत|बचत',
  );

  if (emergencyRegex.hasMatch(t)) {
    return "EMERGENCY";
  }

  // --------------------
  // INCOME
  // --------------------
  final incomeRegex = RegExp(
    r'कमाई|नौकरी|फाइनेंशियल|आमदनी|income|job|financial|naukri',
  );

  if (incomeRegex.hasMatch(t)) {
    return "INCOME";
  }

  return "GENERAL";
}
