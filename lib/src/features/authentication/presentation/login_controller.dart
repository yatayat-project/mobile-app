import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context.dart';
import '../../../core/utils/query_context.dart';
import '../../../models/error/modal.dart';
import '../../../models/response/api_response.dart';
import '../../../widgets/atoms/loader_dialog.dart';
import '../application/auth_services.dart';
import '../modal/app_user.dart';
import '../modal/auth_response.dart';
import '../modal/login_params.dart';

final loginControllerProvider =
    AsyncNotifierProvider.autoDispose<LoginController, void>(
  LoginController.new,
);

final rememberMe = StateProvider<bool>((ref) {
  return false;
});

class LoginController extends AutoDisposeAsyncNotifier<void> {
  LoginController() : super();

  late GlobalKey<FormBuilderState> formKey;

  late AuthenticationService authenticationService;

  @override
  FutureOr build() {
    formKey = GlobalKey<FormBuilderState>();
    authenticationService = ref.watch(authServiceProvider);
  }

  final authUserNotifier = ValueNotifier<AuthResponse?>(null);

  /// login
  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      screenLoader();
      QueryContext queryContext = QueryContext(
        params: LoginParams(
          phone: formKey.currentState!.fields['phone_number']!.value,
          password: formKey.currentState!.fields['password']!.value,
        ),
      );
      state = const AsyncLoading();
      final data = await AsyncValue.guard<APIResponse<AuthResponse>>(
        () => authenticationService.signIn(context: queryContext),
      );
      state = data;
      log("login response:::${data.asData?.value}");
      APIResponse<AuthResponse> response = data.asData!.value;
      APIError? error = response.error;
      if (error != null) {
        context.pop();
        context.showError(error.message.toString());
      } else {
        context.pop();
        formKey.currentState!.reset();
        context.showSuccess("Successfully logged in!!");
      }
    }
  }

  ValueNotifier<AppUser?> get onAuthStateChange =>
      authenticationService.onAuthStateChange;

  /// validations
  String? validatePhoneNumber(String? value) {
    if (value == null || value == "") {
      return "Phone numbers is required";
    }
    const pattern = r'^(?:\+977)?(98|97)\d{8}(-\d{4})?$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Invalid phone number";
    }
    return null;
  }

  Future<void> logout() => authenticationService.logout();

  ///
  String? validatePassword(String? value) {
    if (value == null || value == "") {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }
}
