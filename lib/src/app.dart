import 'package:easy_localization/easy_localization.dart'
    show BuildContextEasyLocalizationExtension, tr;
import 'package:flutter/foundation.dart' show Key, Listenable, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import 'package:form_builder_validators/form_builder_validators.dart'
    show FormBuilderLocalizations;
import 'package:sizer/sizer.dart' show Sizer;

import 'config/router/app_router.dart';
import 'config/themes/app_theme.dart';
import 'features/authentication/presentation/login_controller.dart';

final mainNavigator = GlobalKey<NavigatorState>();

class App extends ConsumerWidget {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref = ref;
    return Sizer(
      builder: (_, orientation, deviceType) {
        return MaterialApp.router(
          locale: context.locale,
          debugShowCheckedModeBanner: !kDebugMode,
          routerConfig: AppRouter(
            ref: ref,
            refreshListenable: Listenable.merge(
              [
                ref.watch(loginControllerProvider.notifier).onAuthStateChange,
              ],
            ),
            navigatorKey: mainNavigator,
          ),
          title: tr("Skeleton"),
          theme: AppTheme.light,
          localizationsDelegates: [
            FormBuilderLocalizations.delegate,
            ...context.localizationDelegates,
          ],
          supportedLocales: context.supportedLocales,
          //  builder: (context, child) => LanguageSwitch(child: child),
        );
      },
    );
  }
}
