import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/theme_providers.dart';

/// App-bar button to pick System / Light / Dark. Reusable on any screen.
class ThemeModeButton extends ConsumerWidget {
  const ThemeModeButton({super.key});

  static const _options = <(ThemeMode, IconData, String)>[
    (ThemeMode.system, Icons.brightness_auto, 'System'),
    (ThemeMode.light, Icons.light_mode, 'Light'),
    (ThemeMode.dark, Icons.dark_mode, 'Dark'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appThemeModeProvider);
    final currentIcon = _options.firstWhere((o) => o.$1 == mode).$2;

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme',
      icon: Icon(currentIcon),
      initialValue: mode,
      onSelected: ref.read(appThemeModeProvider.notifier).setMode,
      itemBuilder: (_) => [
        for (final (value, icon, label) in _options)
          PopupMenuItem<ThemeMode>(
            value: value,
            child: Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(label)),
                if (value == mode) const Icon(Icons.check, size: 18),
              ],
            ),
          ),
      ],
    );
  }
}
