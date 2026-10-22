import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required DateTime createdAt,
    @Default(false) bool isCompleted,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

extension TodoIterableX on Iterable<Todo> {
  /// Single place that defines list order (used by repository and notifier).
  List<Todo> sortedNewestFirst() =>
      toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}
