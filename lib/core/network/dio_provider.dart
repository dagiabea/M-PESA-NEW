import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safaricom_test/core/network/api_constants.dart';
import 'package:safaricom_test/core/network/api_exception.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.timeout,
      receiveTimeout: ApiConstants.timeout,
      headers: const {'Content-Type': 'application/json'},
    ),
  );
});

ApiException mapDioError(DioException error) {
  final data = error.response?.data;
  if (data is Map<String, dynamic>) {
    final message = data['message'] as String?;
    final errorBody = data['error'];
    final details = errorBody is Map<String, dynamic>
        ? errorBody['details'] as String?
        : null;
    final code = errorBody is Map<String, dynamic>
        ? errorBody['code'] as String?
        : null;
    return ApiException(details ?? message ?? 'Something went wrong', code: code);
  }

  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    return const ApiException('Connection timed out. Please try again.');
  }

  if (error.type == DioExceptionType.connectionError) {
    return const ApiException('No internet connection.');
  }

  return const ApiException('Something went wrong. Please try again.');
}
