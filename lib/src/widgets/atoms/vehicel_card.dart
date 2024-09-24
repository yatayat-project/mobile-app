// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';
import '../../features/vechicle_document_onboarding/presentation/document_update.dart';
import '../../features/vehicle_list/modal/vehilce_list_response.dart';
import 'custom_tag.dart';
import 'image_picker_sheet.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (vehicle.documents.isNotEmpty) {
          bool readOnly =
              vehicle.overallStatus == VehicleStatusType.approved.name ||
                  vehicle.overallStatus == VehicleStatusType.pending.name ||
                  vehicle.isUpdated == 1;

          context.push(
            DocumentUpdate.routeName,
            extra: {"doc": vehicle.documents, "readOnly": readOnly},
          );
        }
      },
      child: Card(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vehicle No: ${vehicle.vehicleNo}',
                    style: context.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  vehicle.overallStatus == VehicleStatusType.approved.name
                      ? const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 24,
                        )
                      : vehicle.isUpdated == 1
                          ? const CustomTag(
                              label: "Updated",
                              tagEnum: TagEnum.rejectedUpdated,
                            )
                          : vehicle.overallStatus ==
                                  VehicleStatusType.rejected.name
                              ? const CustomTag(
                                  label: "Rejected",
                                  tagEnum: TagEnum.rejected,
                                )
                              : vehicle.overallStatus ==
                                      VehicleStatusType.pending.name
                                  ? const CustomTag(
                                      label: "Pending",
                                      tagEnum: TagEnum.pending,
                                    )
                                  : const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),

              // Main Details Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type: ${vehicle.type}',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        vehicle.type == "zonal"
                            ? "Zone: ${vehicle.zone}"
                            : "Province: ${vehicle.province}",
                        style: context.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'Lot No: ${vehicle.lotNo}',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        'Vehicle Symbol: ${vehicle.vehicleSymbol}',
                        style: context.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: AppColors.black,
                        ),
                      ),
                      vehicle.type == "province"
                          ? Text(
                              'Office code: ${vehicle.officeCode}',
                              style: context.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      vehicle.embossNo != null
                          ? Text(
                              'Embossed No: ${vehicle.embossNo ?? ""}',
                              style: context.bodyMedium!.copyWith(
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),

              // // Metadata Section
              // Text(
              //   'Created At: ${formatDateTime(vehicle.createdAt)}',
              //   style: context.bodyMedium!.copyWith(
              //     fontSize: 14,
              //     color: AppColors.greyDark,
              //   ),
              // ),
              // Text(
              //   'Updated At: ${formatDateTime(vehicle.updatedAt)}',
              //   style: context.bodyMedium!.copyWith(
              //     fontSize: 14,
              //     color: AppColors.greyDark,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDateTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  String date =
      '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  String time =
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}
