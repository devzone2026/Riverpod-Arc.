import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../domain/todo.dart';
import 'todo_dto.dart';

part 'todo_remote_data_source.g.dart';

@Riverpod(keepAlive: true)
TodoRemoteDataSource todoRemoteDataSource(Ref ref) =>
    TodoRemoteDataSource(ref.watch(dioProvider));

/// Talks to the REST API using Dio.
class TodoRemoteDataSource {
  TodoRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<Todo>> fetchTodos({int limit = 10}) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        '/todos',
        queryParameters: {'_limit': limit},
      );
      final data = response.data ?? const <dynamic>[];
      final now = DateTime.now();

      return [
        for (var i = 0; i < data.length; i++)
          TodoDto.fromJson(Map<String, dynamic>.from(data[i] as Map)).toDomain(
            // Keeps the API order when sorted newest-first.
            createdAt: now.subtract(Duration(seconds: i)),
          ),
      ];
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
