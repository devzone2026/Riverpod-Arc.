import 'dart:async';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/storage/hive_providers.dart';
import '../../../core/utils/id_generator.dart';
import '../domain/chat_message.dart';
import '../domain/chat_settings.dart';

part 'chat_local_data_source.g.dart';

@Riverpod(keepAlive: true)
ChatLocalDataSource chatLocalDataSource(Ref ref) => ChatLocalDataSource(
      history: ref.watch(chatBoxProvider),
      settings: ref.watch(settingsBoxProvider),
    );

/// Hive storage for chat history (last [maxMessages]) and chat settings.
class ChatLocalDataSource {
  ChatLocalDataSource({
    required this._history,
    required this._settings,
  });

  static const maxMessages = 200;
  static const _userIdKey = 'userId';
  static const _usernameKey = 'username';
  static const _serverUrlKey = 'serverUrl';

  final Box<dynamic> _history;
  final Box<dynamic> _settings;

  // ---- history ----
  List<ChatMessage> loadHistory() {
    final messages = <ChatMessage>[];
    for (final value in _history.values) {
      try {
        messages.add(ChatMessage.fromJson(Map<String, dynamic>.from(value as Map)));
      } catch (_) {}
    }
    return messages;
  }

  Future<void> saveMessage(ChatMessage message) async {
    await _history.add(message.toJson());
    final overflow = _history.length - maxMessages;
    if (overflow > 0) {
      // Auto-increment keys are ascending, so the first keys are the oldest.
      await _history.deleteAll(_history.keys.take(overflow).toList());
    }
  }

  Future<void> clearHistory() async {
    await _history.clear();
  }

  // ---- settings ----
  /// Creates the anonymous user id / default name on first launch.
  ChatSettings loadSettings() {
    var userId = _settings.get(_userIdKey) as String?;
    if (userId == null) {
      userId = generateId();
      unawaited(_settings.put(_userIdKey, userId));
    }

    var username = _settings.get(_usernameKey) as String?;
    if (username == null) {
      username = 'User${1000 + Random().nextInt(9000)}';
      unawaited(_settings.put(_usernameKey, username));
    }

    return ChatSettings(
      userId: userId,
      username: username,
      serverUrl: _settings.get(_serverUrlKey) as String? ??
          AppConfig.defaultChatServerUrl,
    );
  }

  Future<void> saveSettings(ChatSettings settings) async {
    await _settings.put(_usernameKey, settings.username);
    await _settings.put(_serverUrlKey, settings.serverUrl);
  }
}
