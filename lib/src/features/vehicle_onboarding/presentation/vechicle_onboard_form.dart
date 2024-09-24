import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../core/utils/shared_keys.dart';
import '../../../injector.dart';
import '../../../models/response/api_response.dart';
import '../../../widgets/atoms/drop_down.dart';
import '../../../widgets/atoms/error_widget.dart';
import '../../../widgets/atoms/text_input.dart';
import '../../vehicle_list/presentation/home_controller.dart';
import '../modal/index.dart';
import 'vechicle_controller.dart';

class OnboardingForm extends ConsumerStatefulWidget {
  const OnboardingForm({super.key});

  static const routeName = "/onboardingForm";

  @override
  OnboardingFormState createState() => OnboardingFormState();
}

class OnboardingFormState extends ConsumerState<OnboardingForm> {
  String? officeCode;
  @override
  void initState() {
    officeCode = sharedPreferences.getString(SharedKeys.officeCode);
    super.initState();
  }

  String initalType = "zonal";

  @override
  Widget build(BuildContext context) {
    final AsyncValue<APIResponse<dynamic>> formValueAsyc =
        ref.watch(vehicleControllerProvider);

    final VehicleCategoryResponse? vehicleData =
        formValueAsyc.valueOrNull?.response;
    final vehicleCtrl = ref.read(vehicleControllerProvider.notifier);
    final state = ref.watch(vehicleControllerProvider);

    return PopScope(
      onPopInvoked: (didPop) {
        ref.invalidate(vehicleListControllerProvider);
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            onPressed: () {
              ref.invalidate(vehicleListControllerProvider);
              context.pop();
            },
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.white,
              size: 20.sp,
            ),
          ),
          centerTitle: false,
          title: Text(
            "Onboarding",
            style: context.displayLarge!.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
        ),
        body: formValueAsyc.when(
          data: (data) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.w),
              child: FormBuilder(
                key: vehicleCtrl.formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: context.height * 1.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropDown(
                          name: "type",
                          required: true,
                          hintText: "Select type",
                          enabled: !formValueAsyc.isLoading,
                          items: vehicleData?.type ?? [],
                          initialValue: vehicleData?.type[0].value,
                          label: "Type",
                          labelStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (initalType != value) {
                                initalType = value!;
                              }
                            });
                            log("value $value");
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Visibility(
                          visible: initalType == "zonal",
                          child: DropDown(
                            name: "zonal",
                            hintText: "Select zonal",
                            required: true,
                            enabled: !formValueAsyc.isLoading,
                            initialValue: vehicleData?.zoneData[0].value,
                            items: vehicleData?.zoneData ?? [],
                            label: "Zonal",
                            labelStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.9),
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              log("value $value");
                            },
                            validator: (p0) {
                              if (p0 == null) {
                                return "Please select zone";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Visibility(
                          visible: initalType == "province",
                          child: DropDown(
                            name: "province",
                            hintText: "Select province",
                            required: true,
                            initialValue: vehicleData?.provinceData[0].value,
                            enabled: !formValueAsyc.isLoading,
                            items: vehicleData?.provinceData ?? [],
                            label: "Province",
                            labelStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.9),
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              log("value $value");
                            },
                            validator: (p0) {
                              if (p0 == null) {
                                return "Please select province";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        DropDown(
                          name: "vehicle_symbol",
                          required: true,
                          hintText: "Select vehicle symbol",
                          enabled: !formValueAsyc.isLoading,
                          items: vehicleData?.vehicleSymbol ?? [],
                          label: "Vehicle symbol",
                          labelStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          validator: (p0) {
                            if (p0 == null) {
                              return "Please select vehicle symbol";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        TextInput(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          required: true,
                          name: "lot_no",
                          label: tr("Lot No."),
                          enabled: !formValueAsyc.isLoading,
                          labelStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.number,
                          hintStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          validator: (value) =>
                              vehicleCtrl.validateLotNumber(value),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        TextInput(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          required: true,
                          name: "vehicle_no",
                          label: tr("Vehicle No."),
                          enabled: !formValueAsyc.isLoading,
                          labelStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          keyboardType: TextInputType.number,
                          hintStyle: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.9),
                            fontSize: 16,
                          ),
                          validator: (value) =>
                              vehicleCtrl.validateVehicleNumber(value),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Visibility(
                          visible: initalType == "province",
                          child: TextInput(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            required: true,
                            name: "office_code",
                            label: tr("Office code"),
                            initialValue: officeCode,
                            enabled: false,
                            labelStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.9),
                              fontSize: 16,
                            ),
                            keyboardType: TextInputType.number,
                            hintStyle: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.black.withOpacity(0.9),
                              fontSize: 16,
                            ),
                            validator: (value) =>
                                vehicleCtrl.validateOfficeCode(value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (err, stackTrace) {
            return ErrorView(
              onRetry: () async {
                ref.invalidate(vehicleControllerProvider);
                try {
                  await ref.read(
                    vehicleControllerProvider.future,
                  );
                } catch (e) {}
              },
            );
          },
          loading: () => SizedBox(
            height: context.height,
            width: context.width,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 4,
              ),
            ),
          ),
        ),
        bottomSheet: state.isLoading || state.error != null
            ? const SizedBox()
            : Container(
                height: kBottomNavigationBarHeight + 14,
                decoration: BoxDecoration(
                  color: AppColors.primary.shade100,
                ),
                width: context.width,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                  child: ElevatedButton(
                    onPressed: () {
                      vehicleCtrl.submitForm(context);
                    },
                    child: Text(
                      "Submit",
                      style: context.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        height: 1,
                      ),
                    ),
                  ),
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
