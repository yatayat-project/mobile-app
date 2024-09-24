import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../core/utils/constants.dart';

class APIHandler {
  // Generic HTTP method
  static Future<dynamic> hitApi(Future<Response> response) async {
    Completer<dynamic> completer = Completer<dynamic>();
    try {
      var res = await response;
      log("🔥🔥🔥🔥🔥🔥🔥🔥res::::$response");
      completer.complete(res.data);
    } on Exception catch (e) {
      log("❌❌❌❌❌❌❌❌exception::$e");
      onError(e, completer);
    }
    return completer.future;
  }
}
