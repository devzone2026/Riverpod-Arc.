import 'package:hive_flutter/hive_flutter.dart';

/// Names of all Hive boxes + one-time initialisation (call from main()).
abstract final class HiveBoxes {
  static const todos = 'todos';
  static const chat = 'chat';
  static const settings = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<dynamic>(todos),
      Hive.openBox<dynamic>(chat),
      Hive.openBox<dynamic>(settings),
    ]);
  }
}
