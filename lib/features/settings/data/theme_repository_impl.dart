import 'package:flutter/material.dart' show ThemeMode;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/hive_providers.dart';
import '../domain/theme_repository.dart';

part 'theme_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ThemeRepository themeRepository(Ref ref) =>
    ThemeRepositoryImpl(ref.watch(settingsBoxProvider));

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl(this._box);

  static const _key = 'themeMode';

  final Box<dynamic> _box;

  @override
  ThemeMode load() {
    final saved = _box.get(_key) as String?;
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system, // default: follow the device setting
    );
  }

  @override
  Future<void> save(ThemeMode mode) => _box.put(_key, mode.name);
}
