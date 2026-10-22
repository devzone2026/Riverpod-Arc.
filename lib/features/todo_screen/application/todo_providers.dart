import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/todo_repository_impl.dart';
import '../domain/todo.dart';
import '../domain/todo_filter.dart';
import '../domain/todo_repository.dart';
import '../domain/todo_stats.dart';

part 'todo_providers.g.dart';

/// All todos as [AsyncValue] (loading / error / data).
///
/// Mutations are optimistic: the UI updates immediately, then the change is
/// persisted; if persisting fails the previous list is restored.
@Riverpod(keepAlive: true)
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() => ref.watch(todoRepositoryProvider).getTodos();

  Future<void> add(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    final now = DateTime.now();
    final todo = Todo(
      id: now.microsecondsSinceEpoch.toString(),
      title: trimmed,
      createdAt: now,
    );
    await _optimistic(
      apply: (current) => [todo, ...current],
      persist: (repo) => repo.save(todo),
    );
  }

  Future<void> toggle(Todo todo) {
    final updated = todo.copyWith(isCompleted: !todo.isCompleted);
    return _optimistic(
      apply: (current) => _replace(current, updated),
      persist: (repo) => repo.save(updated),
    );
  }

  Future<void> edit(Todo todo, String newTitle) {
    final trimmed = newTitle.trim();
    if (trimmed.isEmpty) return Future.value();
    final updated = todo.copyWith(title: trimmed);
    return _optimistic(
      apply: (current) => _replace(current, updated),
      persist: (repo) => repo.save(updated),
    );
  }

  Future<void> remove(String id) => _optimistic(
        apply: (current) => current.where((t) => t.id != id).toList(),
        persist: (repo) => repo.delete(id),
      );

  /// Used by "Undo" after a delete. Order is restored via createdAt.
  Future<void> restore(Todo todo) => _optimistic(
        apply: (current) => current.any((t) => t.id == todo.id)
            ? current
            : [...current, todo].sortedNewestFirst(),
        persist: (repo) => repo.save(todo),
      );

  Future<void> clearCompleted() async {
    final ids = (state.value ?? const <Todo>[])
        .where((t) => t.isCompleted)
        .map((t) => t.id)
        .toSet();
    if (ids.isEmpty) return;
    await _optimistic(
      apply: (current) => current.where((t) => !ids.contains(t.id)).toList(),
      persist: (repo) => repo.deleteAll(ids),
    );
  }

  Future<void> setAllCompleted(bool completed) async {
    final updated = [
      for (final t in state.value ?? const <Todo>[])
        t.copyWith(isCompleted: completed),
    ];
    if (updated.isEmpty) return;
    await _optimistic(
      apply: (_) => updated,
      persist: (repo) => repo.saveAll(updated),
    );
  }

  /// Re-reads everything from the repository (e.g. after an API import).
  Future<void> reload() async {
    final todos = await ref.read(todoRepositoryProvider).getTodos();
    if (ref.mounted) state = AsyncData(todos);
  }

  // ------------------------------------------------------------------ helpers

  List<Todo> _replace(List<Todo> list, Todo updated) =>
      [for (final t in list) t.id == updated.id ? updated : t];

  Future<void> _optimistic({
    required List<Todo> Function(List<Todo> current) apply,
    required Future<void> Function(TodoRepository repo) persist,
  }) async {
    final previous = state.value;
    if (previous == null) return; // still loading / failed to load
    state = AsyncData(apply(previous));
    try {
      await persist(ref.read(todoRepositoryProvider));
    } catch (_) {
      if (ref.mounted) state = AsyncData(previous); // roll back
      rethrow;
    }
  }
}

/// Imports todos from the REST API.
/// State = number of newly added todos (null before the first import).
@Riverpod(keepAlive: true)
class TodoSync extends _$TodoSync {
  @override
  FutureOr<int?> build() => null;

  Future<void> importFromApi() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    final result = await AsyncValue.guard<int?>(() async {
      final added = await ref.read(todoRepositoryProvider).importFromRemote();
      await ref.read(todoListProvider.notifier).reload();
      return added;
    });
    if (ref.mounted) state = result;
  }
}

/// Selected filter tab.
@Riverpod(keepAlive: true)
class SelectedFilter extends _$SelectedFilter {
  @override
  TodoFilter build() => TodoFilter.all;

  void setFilter(TodoFilter filter) => state = filter;
}

/// Current search text.
@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

/// Derived: todos after applying filter + search.
@riverpod
List<Todo> filteredTodos(Ref ref) {
  final todos = ref.watch(todoListProvider).value ?? const <Todo>[];
  final filter = ref.watch(selectedFilterProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  return todos.where((t) {
    final matchesFilter = switch (filter) {
      TodoFilter.all => true,
      TodoFilter.active => !t.isCompleted,
      TodoFilter.completed => t.isCompleted,
    };
    final matchesQuery = query.isEmpty || t.title.toLowerCase().contains(query);
    return matchesFilter && matchesQuery;
  }).toList();
}

/// Derived: counts for the header and menu.
@riverpod
TodoStats todoStats(Ref ref) {
  final todos = ref.watch(todoListProvider).value ?? const <Todo>[];
  return TodoStats(
    total: todos.length,
    completed: todos.where((t) => t.isCompleted).length,
  );
}
