import 'dart:async';
import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/config/app_config.dart';
import '../../../core/utils/id_generator.dart';
import '../data/chat_repository_impl.dart';
import '../domain/chat_event.dart';
import '../domain/chat_message.dart';
import '../domain/chat_repository.dart';
import '../domain/chat_state.dart';

part 'chat_providers.g.dart';

/// Owns the live chat: connection lifecycle, auto-reconnect and message list.
@Riverpod(keepAlive: true)
class Chat extends _$Chat {
  static const _maxInMemory = 500;

  StreamSubscription<ChatEvent>? _subscription;
  Timer? _reconnectTimer;
  int _attempt = 0;
  int _generation = 0; // bumps on every connect(); stale callbacks are ignored

  ChatRepository get _repo => ref.read(chatRepositoryProvider);

  @override
  ChatState build() {
    ref.onDispose(() {
      _reconnectTimer?.cancel();
      _subscription?.cancel();
    });

    final repo = ref.watch(chatRepositoryProvider);
    final initial = ChatState(
      settings: repo.loadSettings(),
      messages: repo.loadHistory(),
    );

    Future.microtask(connect);
    return initial;
  }

  // ---------------------------------------------------------------- connect

  Future<void> connect() async {
    if (!ref.mounted) return;
    _reconnectTimer?.cancel();
    await _subscription?.cancel();
    _subscription = null;
    if (!ref.mounted) return;

    final generation = ++_generation;
    final uri = Uri.tryParse(state.settings.serverUrl);
    final validUri = uri != null &&
        (uri.scheme == 'ws' || uri.scheme == 'wss') &&
        uri.host.isNotEmpty;

    if (!validUri) {
      state = state.copyWith(status: ChatStatus.disconnected, online: 0);
      return; // invalid URL: don't keep retrying
    }

    state = state.copyWith(status: ChatStatus.connecting);

    try {
      final stream = await _repo.connect(uri);
      if (!ref.mounted || generation != _generation) return;

      _attempt = 0;
      state = state.copyWith(status: ChatStatus.connected);
      _subscription = stream.listen(
        _onEvent,
        onDone: () => _onClosed(generation),
        onError: (Object _) => _onClosed(generation),
        cancelOnError: true,
      );
    } catch (_) {
      _onClosed(generation);
    }
  }

  void _onClosed(int generation) {
    if (!ref.mounted || generation != _generation) return;
    _subscription?.cancel();
    _subscription = null;
    unawaited(_repo.disconnect());
    state = state.copyWith(status: ChatStatus.disconnected, online: 0);
    _scheduleReconnect();
  }

  /// Exponential backoff: 1s, 2s, 4s, 8s, 16s, then 30s.
  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    final seconds = min(30, 1 << min(_attempt, 5));
    _attempt++;
    _reconnectTimer = Timer(Duration(seconds: seconds), connect);
  }

  /// Manual retry (e.g. from the "Retry now" button).
  Future<void> reconnect() {
    _attempt = 0;
    return connect();
  }

  // ------------------------------------------------------------------ events

  void _onEvent(ChatEvent event) {
    switch (event) {
      case ChatMessageReceived(:final message):
        if (message.text.isEmpty ||
            state.messages.any((m) => m.id == message.id)) {
          return;
        }
        var messages = [...state.messages, message];
        if (messages.length > _maxInMemory) {
          messages = messages.sublist(messages.length - _maxInMemory);
        }
        state = state.copyWith(messages: messages);
        unawaited(_repo.saveMessage(message));
      case ChatPresenceChanged(:final online):
        state = state.copyWith(online: online);
    }
  }

  // ----------------------------------------------------------------- actions

  /// Sends a message. It appears in the list once the server broadcasts it
  /// back, so everyone (including the sender) sees the same ordering.
  bool send(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.status != ChatStatus.connected) return false;
    return _repo.sendMessage(
      ChatMessage(
        id: generateId(),
        senderId: state.settings.userId,
        sender: state.settings.username,
        text: trimmed,
        timestamp: DateTime.now(), // the server stamps its own time
      ),
    );
  }

  Future<void> updateSettings({
    required String username,
    required String serverUrl,
  }) async {
    final current = state.settings;
    final updated = current.copyWith(
      username: username.trim().isEmpty ? current.username : username.trim(),
      serverUrl: serverUrl.trim().isEmpty
          ? AppConfig.defaultChatServerUrl
          : serverUrl.trim(),
    );

    await _repo.saveSettings(updated);
    if (!ref.mounted) return;
    state = state.copyWith(settings: updated);

    if (updated.serverUrl != current.serverUrl) await reconnect();
  }

  Future<void> clearHistory() async {
    await _repo.clearHistory();
    if (!ref.mounted) return;
    state = state.copyWith(messages: const []);
  }
}
