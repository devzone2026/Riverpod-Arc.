import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/todo.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

/// Shape of a todo as returned by the REST API (JSONPlaceholder).
@freezed
abstract class TodoDto with _$TodoDto {
  const TodoDto._();

  const factory TodoDto({
    required int id,
    @Default('') String title,
    @Default(false) bool completed,
  }) = _TodoDto;

  factory TodoDto.fromJson(Map<String, dynamic> json) => _$TodoDtoFromJson(json);

  Todo toDomain({required DateTime createdAt}) => Todo(
        id: 'remote_$id',
        title: title.trim(),
        isCompleted: completed,
        createdAt: createdAt,
      );
}
