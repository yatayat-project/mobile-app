import '../../../models/response/api_response.dart';

import '../modal/index.dart';

abstract class VehicleOnboardingRepo {
  Future<APIResponse<VehicleCategoryResponse>> getVehicleCategory();
}
