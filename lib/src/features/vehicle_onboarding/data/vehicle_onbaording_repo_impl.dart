import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_handler.dart';
import '../../../config/api/api_s.dart';
import '../../../models/error/modal.dart';
import '../../../models/response/api_response.dart';

import '../modal/index.dart';
import 'vehicle_onbaording_repo.dart';

class VehicleOnboardingService extends VehicleOnboardingRepo {
  @override
  Future<APIResponse<VehicleCategoryResponse>> getVehicleCategory() async {
    final request = dio.get(
      APIs.category,
    );
    final response = await APIHandler.hitApi(request);
    if (response is APIError) {
      return APIResponse<VehicleCategoryResponse>(error: response);
    }
    return APIResponse<VehicleCategoryResponse>(
      response: VehicleCategoryResponse.fromJson(response),
    );
  }
}

final vehicleControllerRepoProvider = Provider<VehicleOnboardingService>((ref) {
  return VehicleOnboardingService();
});
