import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show GoRoute, GoRouter, RoutingConfig;

import '../../core/utils/shared_keys.dart';
import '../../features/authentication/modal/app_user.dart';
import '../../features/authentication/presentation/login.dart';
import '../../features/authentication/presentation/login_controller.dart';
import '../../features/not_found.dart';
import '../../features/profile/presentation/profile.dart';
import '../../features/vechicle_document_onboarding/presentation/document_onboarding.dart';
import '../../features/vechicle_document_onboarding/presentation/document_update.dart';
import '../../features/vechicle_document_onboarding/presentation/gallery_image_view.dart';
import '../../features/vehicle_list/modal/vehilce_list_response.dart';
import '../../features/vehicle_list/presentation/home.dart';

import '../../features/vehicle_onboarding/presentation/vechicle_onboard_form.dart';
import '../../injector.dart';
import 'app_route_config.dart';

class AppRouter extends GoRouter {
  final WidgetRef ref;

  AppRouter({
    super.refreshListenable,
    required this.ref,
    super.navigatorKey,
  }) : super.routingConfig(
          routingConfig: ConstantRoutingConfig(
            RoutingConfig(
              routes: <GoRoute>[
                GoRoute(
                  path: Login.routeName,
                  builder: (context, state) => const Login(),
                ),
                GoRoute(
                  path: Home.routeName,
                  builder: (context, state) => const Home(),
                ),
                GoRoute(
                  path: OnboardingForm.routeName,
                  builder: (context, state) => const OnboardingForm(),
                ),
                GoRoute(
                  path: Profile.routeName,
                  builder: (context, state) => const Profile(),
                ),
                GoRoute(
                  path: DocumentOnboarding.routeName,
                  builder: (context, state) => const DocumentOnboarding(),
                ),
                GoRoute(
                  path: DocumentOnboarding.routeName,
                  builder: (context, state) => const DocumentOnboarding(),
                ),
                GoRoute(
                  path: GalleryView.routeName,
                  builder: (context, state) => GalleryView(
                    rejectedDoc: state.extra as List<Document>,
                  ),
                ),
                GoRoute(
                  path: DocumentUpdate.routeName,
                  builder: (context, state) => DocumentUpdate(
                    readOnlyMode:
                        (state.extra as Map<String, dynamic>)["readOnly"],
                    rejectedDoc: (state.extra as Map<String, dynamic>)["doc"]
                        as List<Document>,
                  ),
                ),
              ],
              redirect: (context, state) {
                final AppUser? user = ref
                    .read(loginControllerProvider.notifier)
                    .onAuthStateChange
                    .value;
                bool isFirstTimeAfterLogin = state.fullPath == Login.routeName;
                String? acessToken =
                    sharedPreferences.getString(SharedKeys.accessToken);

                if (isFirstTimeAfterLogin &&
                    user != null &&
                    acessToken != null) {
                  return Home.routeName;
                } else if (user != null && acessToken != null) {
                  return state.fullPath == "/"
                      ? Home.routeName
                      : state.fullPath;
                } else {
                  return Login.routeName;
                }
              },
            ),
          ),
          initialLocation: Login.routeName,
          errorBuilder: (context, state) => const NotFoundPage(),
        );
}
