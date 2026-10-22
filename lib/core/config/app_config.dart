import 'package:flutter/foundation.dart';

abstract final class AppConfig {
  /// Public fake REST API used for the "Import from API" feature.
  static const apiBaseUrl = 'https://jsonplaceholder.typicode.com';

  /// Default WebSocket chat server. The user can change it in the chat settings.
  /// - Android emulator reaches the host machine via 10.0.2.2
  /// - iOS simulator / desktop / web use localhost
  /// - A physical device needs your computer's LAN IP, e.g. ws://192.168.1.20:8080
  static String get defaultChatServerUrl {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'ws://10.0.2.2:8080';
    }
    return 'ws://localhost:8080';
  }
}
