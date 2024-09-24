import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../core/utils/assets_string.dart';
import '../../../widgets/atoms/text_input.dart';
import 'login_controller.dart';

class Login extends ConsumerStatefulWidget {
  static const String routeName = "/login";

  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  Widget build(BuildContext context) {
    final loginCtrlRead = ref.read(loginControllerProvider.notifier);
    final state = ref.watch(loginControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primary.shade50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetString.appLogo,
                height: 60.sp,
                width: 60.sp,
              ),
              SizedBox(
                height: 5.w,
              ),
              Text(
                "For Sign In",
                style: context.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 1.w,
              ),
              Text(
                "Please kindly fill up the form",
                style: context.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.9),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              FormBuilder(
                key: loginCtrlRead.formKey,
                child: Column(
                  children: [
                    TextInput(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      required: true,
                      name: "phone_number",
                      label: tr("Phone Number"),
                      labelStyle: context.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      keyboardType: TextInputType.phone,
                      hintStyle: context.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      validator: (value) =>
                          loginCtrlRead.validatePhoneNumber(value),
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    TextInput(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      required: true,
                      name: "password",
                      label: tr("Password"),
                      keyboardType: TextInputType.visiblePassword,
                      labelStyle: context.bodySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      validator: (value) =>
                          loginCtrlRead.validatePassword(value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  if (state.isLoading) return;

                  loginCtrlRead.login(context);
                },
                child: Text(
                  "Login",
                  style: context.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
