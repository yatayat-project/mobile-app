import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/query_context.dart';
import '../../../models/response/api_response.dart';
import '../data/auth_repository.dart';
import '../data/authentication_repository_impl.dart';
import '../modal/app_user.dart';
import '../modal/auth_response.dart';

class AuthenticationService {
  AuthenticationService({required this.authRepository});

  final AuthRepository authRepository;

  Future<APIResponse<AuthResponse>> signIn({
    required QueryContext context,
  }) async {
    final response = await authRepository.login(context: context);
    if (response.error != null) {
      return response;
    }
    await authRepository.loggedUser(response.response!);
    return response;
  }

  ValueNotifier<AppUser?> get onAuthStateChange =>
      authRepository.onAuthStateChange;

  Future<void> logout() => authRepository.logout();
}

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(
    authRepository: ref.watch(authRepositoryProvider),
  );
});
