import '../error/modal.dart';

class APIResponse<T> {
  APIError? error;
  T? response;
  APIResponse({this.error, this.response});
}
