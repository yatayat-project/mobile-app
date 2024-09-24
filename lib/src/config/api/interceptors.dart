import 'dart:io';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

import '../../../config.dart';
import '../../core/extensions/context.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/shared_keys.dart';
import '../../features/authentication/presentation/login.dart';
import '../../features/authentication/presentation/login_controller.dart';
import '../../injector.dart';
import 'api_s.dart';

class DioAuthInterceptors extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      String? token = sharedPreferences.getString(SharedKeys.accessToken);
      bool needToken = true;

      if (options.uri.toString() == (Config.apiUrl + APIs.login).toString()) {
        needToken = false;
      }
      if (token != null && needToken) {
        options.headers
            .addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
      }
      handler.next(options);
    } catch (_) {}
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      if (err.response?.data != null) {
        // ignore: avoid_dynamic_calls
        if (err.response!.data["message"] == "Unauthenticated.") {
          await providerContainer
              .read(loginControllerProvider.notifier)
              .logout();
          // ignore: avoid_dynamic_calls
          currentContext.showError(err.response!.data["message"].toString());
          currentContext.go(Login.routeName);
          providerContainer.dispose();
        }
      }
    }
    handler.next(err);
  }
}
