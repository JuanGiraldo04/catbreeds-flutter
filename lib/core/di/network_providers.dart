import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../network/logging_interceptor.dart';

/// Provides a configured Dio instance.
/// This is a global dependency shared across the app.
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-api-key': ApiConstants.apiKey,
      },
    ),
  );

  dio.interceptors.add(const LoggingInterceptor());

  return dio;
});
