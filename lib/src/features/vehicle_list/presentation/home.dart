import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../widgets/atoms/app_header.dart';
import '../../../widgets/atoms/error_widget.dart';
import '../../../widgets/atoms/vehicel_card.dart';
import '../../../widgets/atoms/vehicel_card_shimmer.dart';
import '../../../widgets/molecules/category_list.dart';
import '../../vehicle_onboarding/presentation/vechicle_onboard_form.dart';
import '../modal/vehicle_args.dart';
import '../modal/vehilce_list_response.dart';
import 'home_controller.dart';
import 'search_controller.dart';

class Home extends ConsumerStatefulWidget {
  static const String routeName = "/";

  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState<Home> {
  static const pageSize = 10;
  late VehicleListArgs vehicleListArgs;
  late GlobalKey<FormBuilderFieldState> textFieldKey;
  @override
  void initState() {
    super.initState();
    textFieldKey = GlobalKey<FormBuilderFieldState>();
  }

  @override
  Widget build(BuildContext context) {
    final filterStatus = ref.watch(filterVehicleListProvider);
    final searchQuery = ref.watch(searchProvider);
    vehicleListArgs = VehicleListArgs(
      page: 1,
      vehicleStatusType: filterStatus,
      query: searchQuery,
    );
    final AsyncValue<VehicleResponseData> responseAsync = ref.watch(
      vehicleListControllerProvider(vehicleListArgs),
    );

    final totalResults = responseAsync.valueOrNull?.data.total ?? 0;

    return Scaffold(
      appBar: appBar(context, textFieldKey),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const CategoryList(),
          Expanded(
            child: responseAsync.when(
              data: (data) {
                return RefreshIndicator(
                  backgroundColor: AppColors.greyLight,
                  onRefresh: () async {
                    ref.invalidate(vehicleListControllerProvider);
                    try {
                      await ref.read(
                        vehicleListControllerProvider(
                          vehicleListArgs,
                        ).future,
                      );
                    } catch (e) {}
                  },
                  child: totalResults == 0
                      ? Center(
                          child: Text(
                            "No Result",
                            style: context.bodyMedium!.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              height: 1,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: totalResults,
                          itemBuilder: (context, index) {
                            final page = index ~/ pageSize + 1;
                            final indexInPage = index % pageSize;
                            vehicleListArgs = VehicleListArgs(
                              page: page,
                              vehicleStatusType: filterStatus,
                              query: searchQuery,
                            );
                            final AsyncValue<VehicleResponseData>
                                responseAsync = ref.watch(
                              vehicleListControllerProvider(vehicleListArgs),
                            );
                            return responseAsync.when(
                              error: (err, stack) {
                                log("error heer $err $stack");
                                if (indexInPage == 0) {
                                  return ErrorView(
                                    onRetry: () async {
                                      ref.invalidate(
                                        vehicleListControllerProvider,
                                      );
                                      try {
                                        await ref.read(
                                          vehicleListControllerProvider(
                                            vehicleListArgs,
                                          ).future,
                                        );
                                      } catch (e) {}
                                    },
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              loading: () {
                                return const VehicleCardShimmer();
                              },
                              data: (response) {
                                // This condition only happens if a
                                //null itemCount is given
                                if (indexInPage >=
                                    response.data.vehicles.length) {
                                  return null;
                                }
                                final vehicle =
                                    response.data.vehicles[indexInPage];
                                return VehicleCard(vehicle: vehicle);
                              },
                            );
                          },
                        ),
                );
              },
              error: (error, stackTrace) {
                log("error $stackTrace");
                if (error is DioException) {
                  DioException exception = error;

                  // ignore: avoid_dynamic_calls
                  if (exception.response?.data["message"] ==
                      "Sorry No Vehicle Found.") {
                    return Center(
                      child: Text(
                        // ignore: avoid_dynamic_calls
                        exception.response?.data["message"],
                        style: context.bodyMedium!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          height: 1,
                        ),
                      ),
                    );
                  }
                }
                return ErrorView(
                  onRetry: () async {
                    log("etry");
                    ref.invalidate(vehicleListControllerProvider);
                    try {
                      await ref.read(
                        vehicleListControllerProvider(vehicleListArgs).future,
                      );
                    } catch (e) {}
                  },
                );
              },
              loading: () {
                return SizedBox(
                  height: context.height,
                  width: context.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      strokeWidth: 4,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: AppColors.primary,
        onPressed: () {
          context.push(OnboardingForm.routeName);
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }
}
