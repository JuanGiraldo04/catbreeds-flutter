import 'either.dart';
import 'failures.dart';

/// Represents the result of an operation that can either succeed with a value of type [T]
/// or fail with a [HttpRequestFailure].
///
/// By convention:
/// - Left  -> Failure
/// - Right -> Success
typedef Result<T> = Either<HttpRequestFailure, T>;

/// Represents an asynchronous operation that returns a [Result].
typedef FutureResult<T> = Future<Result<T>>;
