import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_stats.freezed.dart';

@freezed
abstract class TodoStats with _$TodoStats {
  const TodoStats._();

  const factory TodoStats({
    @Default(0) int total,
    @Default(0) int completed,
  }) = _TodoStats;

  int get active => total - completed;
  double get progress => total == 0 ? 0 : completed / total;
}
