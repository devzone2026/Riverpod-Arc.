import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_settings.freezed.dart';

@freezed
abstract class ChatSettings with _$ChatSettings {
  const factory ChatSettings({
    /// Stable anonymous id for this install (tells "my" messages apart).
    required String userId,
    required String username,
    required String serverUrl,
  }) = _ChatSettings;
}
