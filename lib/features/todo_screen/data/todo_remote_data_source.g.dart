// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(todoRemoteDataSource)
final todoRemoteDataSourceProvider = TodoRemoteDataSourceProvider._();

final class TodoRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          TodoRemoteDataSource,
          TodoRemoteDataSource,
          TodoRemoteDataSource
        >
    with $Provider<TodoRemoteDataSource> {
  TodoRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TodoRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TodoRemoteDataSource create(Ref ref) {
    return todoRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoRemoteDataSource>(value),
    );
  }
}

String _$todoRemoteDataSourceHash() =>
    r'1891f5732b52202a11817ec1722dbc72662471fc';
