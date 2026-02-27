import 'package:dio/dio.dart';

import 'failures.dart';

/// Maps exceptions to [HttpRequestFailure] instances.
class ExceptionMapper {
  const ExceptionMapper._();

  static HttpRequestFailure mapExceptionToFailure(dynamic exception) {
    if (exception is DioException) {
      return _mapDioException(exception);
    }

    if (exception is FormatException) {
      return HttpRequestFailure.validation(
        message: 'Invalid data format: ${exception.message}',
      );
    }

    if (exception is StateError) {
      return HttpRequestFailure.local(
        message: 'State error: ${exception.message}',
      );
    }

    return HttpRequestFailure.unknown(message: exception.toString());
  }

  static HttpRequestFailure _mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return HttpRequestFailure.timeout(
          message: 'Request timeout: ${exception.message}',
        );

      case DioExceptionType.connectionError:
        return HttpRequestFailure.network(
          message: 'Connection error: ${exception.message}',
        );

      case DioExceptionType.badResponse:
        return _mapHttpStatusCode(exception);

      case DioExceptionType.cancel:
        return const HttpRequestFailure.local(message: 'Request was cancelled');

      case DioExceptionType.badCertificate:
        return HttpRequestFailure.network(
          message: 'Bad certificate: ${exception.message}',
        );

      case DioExceptionType.unknown:
        return HttpRequestFailure.unknown(
          message: 'Unknown error: ${exception.message}',
        );
    }
  }

  static HttpRequestFailure _mapHttpStatusCode(DioException exception) {
    final statusCode = exception.response?.statusCode;

    switch (statusCode) {
      case 400:
        return HttpRequestFailure.badRequest(
          message: _extractErrorMessage(exception) ?? 'Bad request',
        );
      case 401:
      case 403:
        return HttpRequestFailure.unauthorized(
          message: _extractErrorMessage(exception) ?? 'Unauthorized access',
        );
      case 404:
        return HttpRequestFailure.notFound(
          message: _extractErrorMessage(exception) ?? 'Resource not found',
        );
      case 422:
        return HttpRequestFailure.validation(
          message: _extractErrorMessage(exception) ?? 'Validation failed',
        );
      case 429:
        return const HttpRequestFailure.server(
          message: 'Too many requests. Please try again later.',
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return HttpRequestFailure.server(
          message:
              _extractErrorMessage(exception) ?? 'Server error ($statusCode)',
        );
      default:
        return HttpRequestFailure.server(
          message:
              _extractErrorMessage(exception) ?? 'HTTP error ($statusCode)',
        );
    }
  }

  static String? _extractErrorMessage(DioException exception) {
    try {
      final data = exception.response?.data;

      if (data is Map<String, dynamic>) {
        return data['message'] as String? ??
            data['error'] as String? ??
            data['detail'] as String?;
      }

      if (data is String) return data;

      return exception.message;
    } catch (_) {
      return exception.message;
    }
  }
}
