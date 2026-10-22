import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/hive_providers.dart';
import '../domain/todo.dart';

part 'todo_local_data_source.g.dart';

@Riverpod(keepAlive: true)
TodoLocalDataSource todoLocalDataSource(Ref ref) =>
    TodoLocalDataSource(ref.watch(todosBoxProvider));

/// Hive-backed storage. Each todo is stored as a JSON map under its id,
/// so no Hive adapters / extra codegen are needed.
class TodoLocalDataSource {
  TodoLocalDataSource(this._box);

  final Box<dynamic> _box;

  List<Todo> loadAll() {
    final todos = <Todo>[];
    for (final value in _box.values) {
      try {
        todos.add(Todo.fromJson(Map<String, dynamic>.from(value as Map)));
      } catch (_) {
        // Skip corrupt entries instead of crashing the app.
      }
    }
    return todos;
  }

  Future<void> put(Todo todo) => _box.put(todo.id, todo.toJson());

  Future<void> putAll(Iterable<Todo> todos) =>
      _box.putAll({for (final t in todos) t.id: t.toJson()});

  Future<void> delete(String id) => _box.delete(id);

  Future<void> deleteAll(Iterable<String> ids) => _box.deleteAll(ids);
}
