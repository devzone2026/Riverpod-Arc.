import 'dart:async';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/theme_repository_impl.dart';

part 'theme_providers.g.dart';

/// Current [ThemeMode] (system / light / dark), persisted via the repository.
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ref.watch(themeRepositoryProvider).load();

  void setMode(ThemeMode mode) {
    if (mode == state) return;
    state = mode;
    unawaited(ref.read(themeRepositoryProvider).save(mode));
  }
}
