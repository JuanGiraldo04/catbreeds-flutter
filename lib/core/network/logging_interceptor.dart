import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs HTTP traffic in debug mode only.
/// In production environments, sensitive data should be redacted.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  void _log(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('┌────────── REQUEST ──────────');
    _log('${options.method} ${options.uri}');
    _log('Headers: ${options.headers}');
    if (options.data != null) {
      _log('Body: ${options.data}');
    }
    _log('──────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('┌────────── RESPONSE ─────────');
    _log('${response.requestOptions.method} ${response.requestOptions.uri}');
    _log('Status: ${response.statusCode}');
    _log('Data: ${response.data}');
    _log('──────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('┌────────── ERROR ────────────');
    _log('${err.requestOptions.method} ${err.requestOptions.uri}');
    _log('Status: ${err.response?.statusCode}');
    _log('Message: ${err.message}');
    if (err.response?.data != null) {
      _log('Data: ${err.response?.data}');
    }
    _log('──────────────────────────────');
    handler.next(err);
  }
}
