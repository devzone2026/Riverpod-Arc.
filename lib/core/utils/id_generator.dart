import 'dart:math';

final _random = Random.secure();

/// Random 16-char hex id (no extra package needed).
String generateId() =>
    List.generate(16, (_) => _random.nextInt(16).toRadixString(16)).join();
