sealed class CallResult<T> {}

class Success<T> extends CallResult<T> {
  T data;

  Success(this.data);
}

class Failure<T> extends CallResult<T> {
  String? cause;
  int code;

  Failure({
    this.cause,
    this.code = 0,
  });

  bool isAuthError() => code == 401;
}

class NetworkError<T> extends CallResult<T> {}

enum ErrorCause {
  networkError,
  socketError,
  timeoutError,
  serverError,
  clientError,
  authError,
  unknownError,
}
