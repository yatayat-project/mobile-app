import 'dart:developer' show log;

import 'package:dio/dio.dart'
    show
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler;

class DataLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("--> ${options.method} ${options.path} ${options.uri}");
    log(options.headers.toString());
    String responseAsString = options.data.toString();
    // ignore: lines_longer_than_80_chars
    log(" \n<-- START PARAMS: \n$responseAsString\nEND PARAMS -->\n<-- END HTTP");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: lines_longer_than_80_chars
    log("<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    // ignore: lines_longer_than_80_chars
    log(" \n<-- START RESPONSE: \n$responseAsString\nEND RESPONSE -->\n<-- END HTTP");
    super.onResponse(response, handler);
  }
}
