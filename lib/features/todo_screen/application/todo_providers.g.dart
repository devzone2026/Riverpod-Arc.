// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All todos as [AsyncValue] (loading / error / data).
///
/// Mutations are optimistic: the UI updates immediately, then the change is
/// persisted; if persisting fails the previous list is restored.

@ProviderFor(TodoList)
final todoListProvider = TodoListProvider._();

/// All todos as [AsyncValue] (loading / error / data).
///
/// Mutations are optimistic: the UI updates immediately, then the change is
/// persisted; if persisting fails the previous list is restored.
final class TodoListProvider
    extends $AsyncNotifierProvider<TodoList, List<Todo>> {
  /// All todos as [AsyncValue] (loading / error / data).
  ///
  /// Mutations are optimistic: the UI updates immediately, then the change is
  /// persisted; if persisting fails the previous list is restored.
  TodoListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoListHash();

  @$internal
  @override
  TodoList create() => TodoList();
}

String _$todoListHash() => r'c5cc04247535b6d626d89b1daa16e23ba2bfee93';

/// All todos as [AsyncValue] (loading / error / data).
///
/// Mutations are optimistic: the UI updates immediately, then the change is
/// persisted; if persisting fails the previous list is restored.

abstract class _$TodoList extends $AsyncNotifier<List<Todo>> {
  FutureOr<List<Todo>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Todo>>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Todo>>, List<Todo>>,
              AsyncValue<List<Todo>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Imports todos from the REST API.
/// State = number of newly added todos (null before the first import).

@ProviderFor(TodoSync)
final todoSyncProvider = TodoSyncProvider._();

/// Imports todos from the REST API.
/// State = number of newly added todos (null before the first import).
final class TodoSyncProvider extends $AsyncNotifierProvider<TodoSync, int?> {
  /// Imports todos from the REST API.
  /// State = number of newly added todos (null before the first import).
  TodoSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoSyncHash();

  @$internal
  @override
  TodoSync create() => TodoSync();
}

String _$todoSyncHash() => r'adce8295810b45430f871435b2606baf85e91a01';

/// Imports todos from the REST API.
/// State = number of newly added todos (null before the first import).

abstract class _$TodoSync extends $AsyncNotifier<int?> {
  FutureOr<int?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<int?>, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int?>, int?>,
              AsyncValue<int?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Selected filter tab.

@ProviderFor(SelectedFilter)
final selectedFilterProvider = SelectedFilterProvider._();

/// Selected filter tab.
final class SelectedFilterProvider
    extends $NotifierProvider<SelectedFilter, TodoFilter> {
  /// Selected filter tab.
  SelectedFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFilterHash();

  @$internal
  @override
  SelectedFilter create() => SelectedFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoFilter>(value),
    );
  }
}

String _$selectedFilterHash() => r'708ba6c2517712510937b7c2558fa3bbb2b7f06f';

/// Selected filter tab.

abstract class _$SelectedFilter extends $Notifier<TodoFilter> {
  TodoFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TodoFilter, TodoFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TodoFilter, TodoFilter>,
              TodoFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Current search text.

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

/// Current search text.
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// Current search text.
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'279d038cd194978d025a4cb4364a431637e1d615';

/// Current search text.

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Derived: todos after applying filter + search.

@ProviderFor(filteredTodos)
final filteredTodosProvider = FilteredTodosProvider._();

/// Derived: todos after applying filter + search.

final class FilteredTodosProvider
    extends $FunctionalProvider<List<Todo>, List<Todo>, List<Todo>>
    with $Provider<List<Todo>> {
  /// Derived: todos after applying filter + search.
  FilteredTodosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTodosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTodosHash();

  @$internal
  @override
  $ProviderElement<List<Todo>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Todo> create(Ref ref) {
    return filteredTodos(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Todo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Todo>>(value),
    );
  }
}

String _$filteredTodosHash() => r'3e121c1fb764b8e4f2e7398f2ee52cf6c394c5dd';

/// Derived: counts for the header and menu.

@ProviderFor(todoStats)
final todoStatsProvider = TodoStatsProvider._();

/// Derived: counts for the header and menu.

final class TodoStatsProvider
    extends $FunctionalProvider<TodoStats, TodoStats, TodoStats>
    with $Provider<TodoStats> {
  /// Derived: counts for the header and menu.
  TodoStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoStatsHash();

  @$internal
  @override
  $ProviderElement<TodoStats> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodoStats create(Ref ref) {
    return todoStats(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoStats value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoStats>(value),
    );
  }
}

String _$todoStatsHash() => r'6c0d4ab85f7771e7979ffd7a90c95a816136f1df';
