import 'package:dio/dio.dart';

import '../../../config.dart';
import '../api/interceptors.dart';
import 'data_logger.dart';

late final Dio dio;

class InitDio {
  call() {
    dio = Dio(
      BaseOptions(
        contentType: "application/json",
        baseUrl: Config.apiUrl,
      ),
    )..interceptors.addAll([
        DioAuthInterceptors(),
        DataLogger(),
      ]);
  }
}
