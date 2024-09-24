import 'dart:async';
import 'dart:developer';

import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_handler.dart';
import '../../../config/api/api_s.dart';
import '../../../core/utils/query_context.dart';
import '../../../core/utils/shared_keys.dart';
import '../../../injector.dart';
import '../../../models/error/modal.dart';
import '../../../models/response/api_response.dart';
import '../modal/app_user.dart';
import '../modal/auth_response.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return HttpAuthenticationRepository();
});

class HttpAuthenticationRepository implements AuthRepository {
  HttpAuthenticationRepository() {
    onAuthStateChange = ValueNotifier(currentUser);
  }
  @override
  AppUser? get currentUser {
    int? userID = sharedPreferences.getInt(SharedKeys.userID);
    String? accessToken = sharedPreferences.getString(SharedKeys.accessToken);
    if (userID == null || accessToken == null) return null;
    return AppUser(
      userID: userID,
      accessToken: accessToken,
    );
  }

  @override
  Future<APIResponse<AuthResponse>> login({
    required QueryContext context,
  }) async {
    final params = context.params;
    final request = dio.post(
      APIs.login,
      data: params == null ? {} : params.toJson(),
    );

    final response = await APIHandler.hitApi(request);
    if (response is APIError) {
      return APIResponse(error: response);
    }

    return APIResponse<AuthResponse>(response: AuthResponse.fromJson(response));
  }

  @override
  Future<void> loggedUser(AuthResponse value) async {
    await sharedPreferences.setString(
      SharedKeys.accessToken,
      value.accessToken,
    );
    await sharedPreferences.setString(
      SharedKeys.officeCode,
      value.data.officeUser!.office!.code,
    );
    await sharedPreferences.setInt(
      SharedKeys.userID,
      value.data.id,
    );
    onAuthStateChange.value =
        AppUser(userID: value.data.id, accessToken: value.accessToken);
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.clear();
    onAuthStateChange.value = null;
  }

  @override
  late ValueNotifier<AppUser?> onAuthStateChange;
}
