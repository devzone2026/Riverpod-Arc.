import 'chat_event.dart';
import 'chat_message.dart';
import 'chat_settings.dart';

/// Everything the chat application layer needs: live connection,
/// local history and settings. Knows nothing about sockets or Hive.
abstract interface class ChatRepository {
  // ---- live connection ----
  /// Opens the connection and returns the stream of server events.
  /// Throws if the connection cannot be established.
  Future<Stream<ChatEvent>> connect(Uri uri);
  Future<void> disconnect();

  /// Returns false when there is no open connection.
  bool sendMessage(ChatMessage message);

  // ---- local history ----
  List<ChatMessage> loadHistory();
  Future<void> saveMessage(ChatMessage message);
  Future<void> clearHistory();

  // ---- settings ----
  ChatSettings loadSettings();
  Future<void> saveSettings(ChatSettings settings);
}
