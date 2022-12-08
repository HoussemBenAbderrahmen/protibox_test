class Result<T> {
  Result._();

  factory Result.success(T data) = Success;
  factory Result.error() = Error;
}

class Error<T> extends Result<T> {
  Error(): super._();
}

class Success<T> extends Result<T> {
  Success(this.data): super._();

  final T data;
}