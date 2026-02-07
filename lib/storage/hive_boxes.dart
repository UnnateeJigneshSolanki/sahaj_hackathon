import 'package:hive/hive.dart';

class HiveBoxes {
  static const String users = 'usersBox';

  static Box get _box => Hive.box(users);

  static bool userExists(String name) {
    return _box.containsKey(name);
  }

  static void saveUser({
    required String name,
    required String gender,
  }) {
    _box.put(name, {
      'name': name,
      'gender': gender,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  static Map<String, dynamic>? getUser(String name) {
    final data = _box.get(name);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }
}
