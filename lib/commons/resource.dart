class Resource<R> {
  Resource(R? data, String? message);

  Resource<T> success<T>(T data) => Resource(data, null);
  Resource<T> loading<T>() => Resource(null, null);
  Resource<T> error<T>(String message) => Resource(null, message);
}