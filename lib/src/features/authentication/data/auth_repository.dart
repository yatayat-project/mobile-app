import 'package:flutter/foundation.dart';

import '../../../core/utils/query_context.dart';
import '../../../models/response/api_response.dart';
import '../modal/app_user.dart';
import '../modal/auth_response.dart';

abstract class AuthRepository {
  /// returns AuthUser if the user is not Login in
  Future<APIResponse<AuthResponse>> login({required QueryContext context});

  /// returns null if the user is not signed in
  AppUser? get currentUser;

  Future<void> loggedUser(AuthResponse value);

  late ValueNotifier<AppUser?> onAuthStateChange;

  Future<void> logout();
}
