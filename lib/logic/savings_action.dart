// savings_actions.dart
// Defines available savings-related actions

class SavingsAction {
  final String key;
  final String description;

  const SavingsAction({required this.key, required this.description});
}

class SavingsActions {
  static const SavingsAction saveSmall = SavingsAction(
    key: "SAVE_SMALL",
    description: "Saved a small amount today",
  );

  static const SavingsAction spendNonEssential = SavingsAction(
    key: "SPEND_NON_ESSENTIAL",
    description: "Spent on non‑essential item",
  );

  static const SavingsAction skipSaving = SavingsAction(
    key: "SKIP_SAVING",
    description: "Did not save today",
  );

  static const Map<String, SavingsAction> all = {
    "SAVE_SMALL": saveSmall,
    "SPEND_NON_ESSENTIAL": spendNonEssential,
    "SKIP_SAVING": skipSaving,
  };
}
