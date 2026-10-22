import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../storage/hive_boxes.dart';

/// Current [ThemeMode] (system / light / dark), persisted in Hive.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _key = 'themeMode';

  Box<dynamic> get _box => Hive.box<dynamic>(HiveBoxes.settings);

  @override
  ThemeMode build() {
    final saved = _box.get(_key) as String?;
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system, // default: follow the device setting
    );
  }

  void set(ThemeMode mode) {
    if (mode == state) return;
    state = mode;
    unawaited(_box.put(_key, mode.name));
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
