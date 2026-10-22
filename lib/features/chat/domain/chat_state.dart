import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message.dart';
import 'chat_settings.dart';

part 'chat_state.freezed.dart';

enum ChatStatus { connecting, connected, disconnected }

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    required ChatSettings settings,
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(ChatStatus.disconnected) ChatStatus status,
    @Default(0) int online,
  }) = _ChatState;
}
