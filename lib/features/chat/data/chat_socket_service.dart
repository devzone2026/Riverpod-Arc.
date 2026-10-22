import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'chat_socket_service.g.dart';

@Riverpod(keepAlive: true)
ChatSocketService chatSocketService(Ref ref) {
  final service = ChatSocketService();
  ref.onDispose(service.disconnect);
  return service;
}

class _Superseded implements Exception {
  const _Superseded();
}

/// Thin wrapper around a WebSocket connection that speaks JSON.
class ChatSocketService {
  WebSocketChannel? _channel;
  int _connectId = 0;

  /// Opens a connection and returns a stream of decoded JSON objects.
  /// Throws if the connection cannot be established.
  Future<Stream<Map<String, dynamic>>> connect(Uri uri) async {
    await disconnect();
    final id = ++_connectId;

    final channel = WebSocketChannel.connect(uri);
    try {
      await channel.ready.timeout(const Duration(seconds: 8));
      if (id != _connectId) throw const _Superseded(); // a newer connect() started
    } catch (_) {
      unawaited(channel.sink.close().catchError((_) {}));
      rethrow;
    }

    _channel = channel;
    return channel.stream
        .map<Map<String, dynamic>?>((raw) {
          try {
            final decoded = jsonDecode(raw as String);
            return decoded is Map<String, dynamic> ? decoded : null;
          } catch (_) {
            return null;
          }
        })
        .where((event) => event != null)
        .cast<Map<String, dynamic>>();
  }

  /// Returns false when there is no open connection.
  bool send(Map<String, dynamic> payload) {
    final channel = _channel;
    if (channel == null) return false;
    channel.sink.add(jsonEncode(payload));
    return true;
  }

  Future<void> disconnect() async {
    _connectId++; // invalidates any connect() still in flight
    final channel = _channel;
    _channel = null;
    if (channel == null) return;
    try {
      await channel.sink.close().timeout(const Duration(seconds: 2), onTimeout: () {});
    } catch (_) {}
  }
}
