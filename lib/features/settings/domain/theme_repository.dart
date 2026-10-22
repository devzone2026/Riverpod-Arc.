import 'package:flutter/material.dart' show ThemeMode;

abstract interface class ThemeRepository {
  ThemeMode load();
  Future<void> save(ThemeMode mode);
}
