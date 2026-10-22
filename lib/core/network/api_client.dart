import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';

part 'api_client.g.dart';

/// Single shared Dio instance.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: const {'Accept': 'application/json'},
    ),
  );

  if (kDebugMode) {
    client.interceptors.add(LogInterceptor(requestBody: true, responseBody: false));
  }

  ref.onDispose(client.close);
  return client;
}

/// User-friendly error thrown by remote data sources.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException('The request timed out. Please try again.');
      case DioExceptionType.connectionError:
        return const ApiException('No internet connection.');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        return ApiException('Server error${code != null ? ' ($code)' : ''}.',
            statusCode: code);
      case DioExceptionType.cancel:
        return const ApiException('Request was cancelled.');
      default:
        return const ApiException('Unexpected network error.');
    }
  }

  @override
  String toString() => message;
}
