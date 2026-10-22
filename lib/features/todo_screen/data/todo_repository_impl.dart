import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/todo.dart';
import '../domain/todo_repository.dart';
import 'todo_local_data_source.dart';
import 'todo_remote_data_source.dart';

part 'todo_repository_impl.g.dart';

@Riverpod(keepAlive: true)
TodoRepository todoRepository(Ref ref) => TodoRepositoryImpl(
      local: ref.watch(todoLocalDataSourceProvider),
      remote: ref.watch(todoRemoteDataSourceProvider),
    );

/// Offline-first: Hive is the source of truth, the API is only used to import.
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl({
    required this._local,
    required this._remote,
  });

  final TodoLocalDataSource _local;
  final TodoRemoteDataSource _remote;

  @override
  Future<List<Todo>> getTodos() async => _local.loadAll().sortedNewestFirst();

  @override
  Future<void> save(Todo todo) => _local.put(todo);

  @override
  Future<void> saveAll(Iterable<Todo> todos) => _local.putAll(todos);

  @override
  Future<void> delete(String id) => _local.delete(id);

  @override
  Future<void> deleteAll(Iterable<String> ids) => _local.deleteAll(ids);

  @override
  Future<int> importFromRemote() async {
    final remote = await _remote.fetchTodos();
    final existingIds = _local.loadAll().map((t) => t.id).toSet();
    final fresh = remote.where((t) => !existingIds.contains(t.id)).toList();
    if (fresh.isNotEmpty) await _local.putAll(fresh);
    return fresh.length;
  }
}
