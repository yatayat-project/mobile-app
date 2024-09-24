import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../models/error/modal.dart';

enum Flavour {
  development,
  production;
}

extension Merge on EdgeInsets {
  EdgeInsets merge(EdgeInsets? other) {
    return copyWith(
      left: other?.left != 0 ? other?.left : left,
      right: other?.right != 0 ? other?.right : right,
      top: other?.top != 0 ? other?.top : top,
      bottom: other?.bottom != 0 ? other?.bottom : bottom,
    );
  }
}

BuildContext get currentContext => mainNavigator.currentState!.context;
BuildContext? get mainContext => mainNavigator.currentState?.context;

class AppLocale {
  static const Locale ja = Locale("ja");
  static const Locale en = Locale("en");
  static const locales = [ja, en];
}

enum ConnectivityStatus { isConnected, isDisconnected, notDetermined }

void onError(Exception e, Completer<dynamic> completer) {
  if (e is DioException) {
    log("❌❌❌❌❌❌❌❌❌❌Exception tow${e.response?.data} ${e.type}");

    if (DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.connectionTimeout == e.type) {
      completer.complete(
        APIError(
          error: "something went wrong",
          message: e.response!.data,
          statusCode: 400,
        ),
      );
    } else if (e.type == DioExceptionType.connectionError) {
      completer.complete(
        APIError(
          error: "Network Error",
          message: e.response!.data,
          statusCode: 404,
        ),
      );
    } else if (e.type == DioExceptionType.unknown) {
      completer.complete(
        APIError(
          error: "Network Error",
          message: e.response!.data,
          statusCode: 404,
        ),
      );
    } else if (e.type == DioExceptionType.badResponse) {
      completer.complete(
        APIError(
          error: "Unauthorized",
          // ignore: avoid_dynamic_calls
          message: e.response?.data["message"] ?? "Unauthorized",
          statusCode: 401,
        ),
      );
    }
  } else {
    completer.complete(APIError(error: e.toString(), statusCode: 500));
  }
}

String? parseErrorMessage(Map<String, dynamic>? response) {
  try {
    return response!["error"];
  } catch (e) {
    return null;
  }
}

final providerContainer = ProviderContainer();
