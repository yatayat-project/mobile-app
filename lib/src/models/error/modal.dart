// updated api error response model as per scala api
class APIError {
  String? error;
  dynamic message;
  int? statusCode;

  APIError({
    this.statusCode,
    this.message,
    this.error,
  });

  APIError.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    return data;
  }
}
