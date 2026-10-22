import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/chat_event.dart';
import '../domain/chat_message.dart';
import '../domain/chat_repository.dart';
import '../domain/chat_settings.dart';
import 'chat_local_data_source.dart';
import 'chat_socket_service.dart';

part 'chat_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) => ChatRepositoryImpl(
      socket: ref.watch(chatSocketServiceProvider),
      local: ref.watch(chatLocalDataSourceProvider),
    );

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl({
    required this._socket,
    required this._local,
  });

  final ChatSocketService _socket;
  final ChatLocalDataSource _local;

  // ---- live connection ----
  @override
  Future<Stream<ChatEvent>> connect(Uri uri) async {
    final raw = await _socket.connect(uri);
    return raw.map(_parseEvent).where((e) => e != null).cast<ChatEvent>();
  }

  @override
  Future<void> disconnect() => _socket.disconnect();

  @override
  bool sendMessage(ChatMessage message) =>
      _socket.send({'type': 'message', ...message.toJson()});

  /// Wire format -> domain event. Unknown / malformed payloads are dropped.
  ChatEvent? _parseEvent(Map<String, dynamic> json) {
    try {
      switch (json['type']) {
        case 'message':
          return ChatEvent.message(ChatMessage.fromJson(json));
        case 'presence':
          final online = json['online'];
          return online is int ? ChatEvent.presence(online) : null;
        default:
          return null;
      }
    } catch (_) {
      return null;
    }
  }

  // ---- local ----
  @override
  List<ChatMessage> loadHistory() => _local.loadHistory();

  @override
  Future<void> saveMessage(ChatMessage message) => _local.saveMessage(message);

  @override
  Future<void> clearHistory() => _local.clearHistory();

  @override
  ChatSettings loadSettings() => _local.loadSettings();

  @override
  Future<void> saveSettings(ChatSettings settings) => _local.saveSettings(settings);
}
