import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_handler.dart';
import '../../../config/api/api_s.dart';
import '../../../core/extensions/context.dart';
import '../../../core/utils/query_context.dart';
import '../../../injector.dart';
import '../../../models/error/modal.dart';
import '../../../models/response/api_response.dart';
import '../../../widgets/atoms/loader_dialog.dart';
import '../../vechicle_document_onboarding/modal/onboaring_params.dart';
import '../../vechicle_document_onboarding/presentation/document_onboarding.dart';
import '../data/vehicle_onbaording_repo_impl.dart';
import '../modal/vehicle_create_response.dart';

class VehicleController extends AutoDisposeAsyncNotifier<APIResponse<dynamic>> {
  VehicleController() : super();
  late VehicleOnboardingService vehicleCategoryService;
  late GlobalKey<FormBuilderState> formKey;

  @override
  FutureOr<APIResponse<dynamic>> build() async {
    formKey = GlobalKey<FormBuilderState>();
    vehicleCategoryService = ref.watch(vehicleControllerRepoProvider);
    return await vehicleCategoryService.getVehicleCategory();
  }

  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      screenLoader();
      final formField = formKey.currentState!.fields;
      QueryContext queryContext = QueryContext(
        params: OnboardingParams(
          type: formField["type"]!.value,
          zone: formField["zonal"]?.value,
          province: formField["province"]?.value,
          vehicleSymbol: formField["vehicle_symbol"]!.value,
          lotNo: int.tryParse(formField['lot_no']!.value)!,
          vehicleNumber: int.tryParse(formField['vehicle_no']!.value)!,
          officeCode: formField['office_code']?.value?.toString(),
        ),
      );
      final params = queryContext.params;
      Future.delayed(const Duration(seconds: 10), () => {});
      final request = dio.post(
        APIs.onboardZone,
        data: params == null ? {} : params.toJson(),
      );

      final response = await APIHandler.hitApi(request);
      if (response is APIError) {
        APIResponse(error: response);
        context.pop();
        context.showError(response.message);
        return;
      } else {
        final data = VehicleCreationResponse.fromJson(response);
        APIResponse<VehicleCreationResponse>(
          response: data,
        );
        sharedPreferences.setInt("vehicle_id", data.data.id);
        formField['lot_no']!.didChange(
          ((int.tryParse(formField['lot_no']!.value))! + 1).toString(),
        );

        formField['vehicle_no']!.didChange(
          ((int.tryParse(formField['vehicle_no']!.value))! + 1).toString(),
        );

        context.showSuccess("Vehicle zone/province set successfully!!");

        // formKey.currentState!.reset();
        context.pop();
        context.push(DocumentOnboarding.routeName);
      }
    }
  }

  String? validateLotNumber(String? value) {
    if (value == null || value == "") {
      return "Lot number is required";
    }
    return null;
  }

  String? validateVehicleNumber(String? value) {
    if (value == null || value == "") {
      return "Vehicle number is required";
    }

    return null;
  }

  String? validateOfficeCode(String? value) {
    if (value == null || value == "") {
      return "Office code is required";
    }

    return null;
  }
}

final vehicleControllerProvider =
    AsyncNotifierProvider.autoDispose<VehicleController, APIResponse<dynamic>>(
  VehicleController.new,
);
