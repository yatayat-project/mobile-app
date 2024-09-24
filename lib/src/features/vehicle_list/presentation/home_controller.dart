import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/api/api.dart';
import '../../../config/api/api_s.dart';
import '../../../widgets/atoms/image_picker_sheet.dart';
import '../modal/vehicle_args.dart';
import '../modal/vehilce_list_response.dart';

class VehicleListController extends AutoDisposeFamilyAsyncNotifier<
    VehicleResponseData, VehicleListArgs> {
  VehicleListController() : super();

  @override
  FutureOr<VehicleResponseData> build(VehicleListArgs arg) async {
    final cancelToken = CancelToken();
    final link = ref.keepAlive();
    Timer? timer;
    ref.onDispose(() {
      cancelToken.cancel();
      timer?.cancel();
    });

    ref.onCancel(() {
      timer = Timer(const Duration(seconds: 30), () {
        // Dispose the cached data on timeout
        link.close();
      });
    });

    ref.onResume(() {
      timer?.cancel();
    });

    if (arg.query!.isNotEmpty) {
      final response = await dio.get(
        APIs.search,
        cancelToken: cancelToken,
        queryParameters: {
          "vehicle_no": arg.query,
        },
      );

      return VehicleResponseData.fromJson(response.data);
    }

    final response = await dio.get(
      APIs.getVehicleList,
      cancelToken: cancelToken,
      queryParameters: {
        "page": arg.page,
        "status": arg.vehicleStatusType.name == ""
            ? "pending"
            : arg.vehicleStatusType.name,
      },
    );
    return VehicleResponseData.fromJson(response.data);
  }
}

final vehicleListControllerProvider = AsyncNotifierProvider.autoDispose
    .family<VehicleListController, VehicleResponseData, VehicleListArgs>(
  VehicleListController.new,
);

final filterVehicleListProvider =
    NotifierProvider.autoDispose<FilterVehicle, VehicleStatusType>(() {
  return FilterVehicle();
});

class FilterVehicle extends AutoDisposeNotifier<VehicleStatusType> {
  @override
  VehicleStatusType build() {
    return VehicleStatusType.pending;
  }

  onFilter({required VehicleStatusType status}) {
    state = status;
  }
}
