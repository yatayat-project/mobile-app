import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/api/api.dart';

late SharedPreferences sharedPreferences;
late WidgetRef globalRef;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];

  //GitHooks.init(targetPath: "bin/git_hooks.dart");

  // init dio
  InitDio()();

  sharedPreferences = await SharedPreferences.getInstance();
}
