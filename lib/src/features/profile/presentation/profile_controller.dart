import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_s.dart';
import '../modal/profile_response.dart';

class ProfileController extends AutoDisposeAsyncNotifier<ProfileData> {
  @override
  FutureOr<ProfileData> build() async {
    final response = await dio.post(
      APIs.profile,
    );
    return ProfileData.fromJson(response.data);
  }
}

final profileControllerProvider =
    AsyncNotifierProvider.autoDispose<ProfileController, ProfileData>(
  ProfileController.new,
);
