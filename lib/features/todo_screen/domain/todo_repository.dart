import 'todo.dart';

/// The only thing the application layer knows about todo data.
/// Implementations decide where it lives (Hive, REST, ...).
abstract interface class TodoRepository {
  /// All todos, newest first.
  Future<List<Todo>> getTodos();

  /// Inserts or replaces a todo.
  Future<void> save(Todo todo);
  Future<void> saveAll(Iterable<Todo> todos);

  Future<void> delete(String id);
  Future<void> deleteAll(Iterable<String> ids);

  /// Fetches todos from the API and stores the ones we don't have yet.
  /// Returns how many were added. Throws `ApiException` on network errors.
  Future<int> importFromRemote();
}
