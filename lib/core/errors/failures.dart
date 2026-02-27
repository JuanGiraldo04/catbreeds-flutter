import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// HttpRequestFailure represents different types of failures that can occur
/// during HTTP requests and other operations.
@freezed
abstract class HttpRequestFailure with _$HttpRequestFailure {
  /// Network-related failures (no internet, DNS issues, etc.)
  const factory HttpRequestFailure.network({
    String? message,
    @Default('Network error') String defaultMessage,
  }) = _Network;

  /// Resource not found (404)
  const factory HttpRequestFailure.notFound({
    String? message,
    @Default('Resource not found') String defaultMessage,
  }) = _NotFound;

  /// Server errors (5xx)
  const factory HttpRequestFailure.server({
    String? message,
    @Default('Server error') String defaultMessage,
  }) = _Server;

  /// Unauthorized access (401)
  const factory HttpRequestFailure.unauthorized({
    String? message,
    @Default('Unauthorized access') String defaultMessage,
  }) = _Unauthorized;

  /// Bad request (400)
  const factory HttpRequestFailure.badRequest({
    String? message,
    @Default('Bad request') String defaultMessage,
  }) = _BadRequest;

  /// Local storage or cache errors
  const factory HttpRequestFailure.local({
    String? message,
    @Default('Local storage error') String defaultMessage,
  }) = _Local;

  /// Request timeout
  const factory HttpRequestFailure.timeout({
    String? message,
    @Default('Request timeout') String defaultMessage,
  }) = _Timeout;

  /// Unknown or unexpected errors
  const factory HttpRequestFailure.unknown({
    String? message,
    @Default('Unknown error') String defaultMessage,
  }) = _Unknown;

  /// Validation errors
  const factory HttpRequestFailure.validation({
    String? message,
    @Default('Validation error') String defaultMessage,
  }) = _Validation;
}

/// Extension to provide convenient methods for HttpRequestFailure
extension HttpRequestFailureExtension on HttpRequestFailure {
  /// Returns the message or the default message if message is null
  String get displayMessage {
    return when(
      network: (message, defaultMessage) => message ?? defaultMessage,
      notFound: (message, defaultMessage) => message ?? defaultMessage,
      server: (message, defaultMessage) => message ?? defaultMessage,
      unauthorized: (message, defaultMessage) => message ?? defaultMessage,
      badRequest: (message, defaultMessage) => message ?? defaultMessage,
      local: (message, defaultMessage) => message ?? defaultMessage,
      timeout: (message, defaultMessage) => message ?? defaultMessage,
      unknown: (message, defaultMessage) => message ?? defaultMessage,
      validation: (message, defaultMessage) => message ?? defaultMessage,
    );
  }

  /// Returns true if this is a network-related error
  bool get isNetworkError {
    return when(
      network: (_, _) => true,
      notFound: (_, _) => false,
      server: (_, _) => false,
      unauthorized: (_, _) => false,
      badRequest: (_, _) => false,
      local: (_, _) => false,
      timeout: (_, _) => true,
      unknown: (_, _) => false,
      validation: (_, _) => false,
    );
  }

  /// Returns true if this is a client error (4xx)
  bool get isClientError {
    return when(
      network: (_, _) => false,
      notFound: (_, _) => true,
      server: (_, _) => false,
      unauthorized: (_, _) => true,
      badRequest: (_, _) => true,
      local: (_, _) => false,
      timeout: (_, _) => false,
      unknown: (_, _) => false,
      validation: (_, _) => true,
    );
  }

  /// Returns true if this is a server error (5xx)
  bool get isServerError {
    return when(
      network: (_, _) => false,
      notFound: (_, _) => false,
      server: (_, _) => true,
      unauthorized: (_, _) => false,
      badRequest: (_, _) => false,
      local: (_, _) => false,
      timeout: (_, _) => false,
      unknown: (_, _) => false,
      validation: (_, _) => false,
    );
  }

  bool get isUnknownError {
    return when(
      network: (_, _) => false,
      notFound: (_, _) => false,
      server: (_, _) => false,
      unauthorized: (_, _) => false,
      badRequest: (_, _) => false,
      local: (_, _) => false,
      timeout: (_, _) => false,
      unknown: (_, _) => true,
      validation: (_, _) => false,
    );
  }
}
