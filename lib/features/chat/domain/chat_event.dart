import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message.dart';

part 'chat_event.freezed.dart';

/// Things the server can tell us. A sealed union, so `switch` is exhaustive.
@freezed
sealed class ChatEvent with _$ChatEvent {
  const factory ChatEvent.message(ChatMessage message) = ChatMessageReceived;
  const factory ChatEvent.presence(int online) = ChatPresenceChanged;
}
