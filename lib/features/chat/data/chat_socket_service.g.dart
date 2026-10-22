// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_socket_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatSocketService)
final chatSocketServiceProvider = ChatSocketServiceProvider._();

final class ChatSocketServiceProvider
    extends
        $FunctionalProvider<
          ChatSocketService,
          ChatSocketService,
          ChatSocketService
        >
    with $Provider<ChatSocketService> {
  ChatSocketServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatSocketServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatSocketServiceHash();

  @$internal
  @override
  $ProviderElement<ChatSocketService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatSocketService create(Ref ref) {
    return chatSocketService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatSocketService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatSocketService>(value),
    );
  }
}

String _$chatSocketServiceHash() => r'185f98090df1d91f41c17303c49e8993c38c26bc';
