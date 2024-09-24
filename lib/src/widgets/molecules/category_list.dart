import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';
import '../../features/vehicle_list/presentation/home_controller.dart';
import '../atoms/category_button.dart';

import '../atoms/image_picker_sheet.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final status = ref.watch(filterVehicleListProvider);
        final read = ref.read(filterVehicleListProvider.notifier);
        return Container(
          height: 40.sp,
          width: context.width,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              top: 4.0,
              bottom: 4.0,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return CategoryButton(
                    isActive: status == VehicleStatusType.pending,
                    onClick: () {
                      read.onFilter(
                        status: VehicleStatusType.pending,
                      );
                    },
                    label: "Pending",
                  );
                }
                if (index == 1) {
                  return CategoryButton(
                    isActive: status == VehicleStatusType.rejected,
                    onClick: () {
                      read.onFilter(
                        status: VehicleStatusType.rejected,
                      );
                    },
                    label: "Rejected",
                  );
                }
                if (index == 2) {
                  return CategoryButton(
                    isActive: status == VehicleStatusType.approved,
                    onClick: () {
                      read.onFilter(
                        status: VehicleStatusType.approved,
                      );
                    },
                    label: "Approved",
                  );
                }
                return null;
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 4.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
