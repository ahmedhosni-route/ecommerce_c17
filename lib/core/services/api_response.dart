sealed class ApiResponse<T> {}

class ApiSuccess<T> extends ApiResponse<T> {
  T data;
  ApiSuccess(this.data);
}

class ApiError<T> extends ApiResponse<T> {
  String message;
  ApiError(this.message);
}
