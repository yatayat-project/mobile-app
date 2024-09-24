import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';
import '../../features/vehicle_list/presentation/home_controller.dart';

enum VehicleStatusType { rejected, pending, approved }

Future<dynamic> imagePickerSheet(
  BuildContext context, {
  required Function(XFile? imageFile) onImagePicked,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.sp),
        height: 90.sp,
        width: SizerUtil.width,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () async {
                context.pop();
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                onImagePicked(image);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.camera,
                    size: 20.sp,
                    color: AppColors.black.withOpacity(0.9),
                  ),
                  SizedBox(
                    width: 16.sp,
                  ),
                  Text(
                    "Take Photo",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.sp,
            ),
            InkWell(
              onTap: () async {
                context.pop();
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                onImagePicked(image);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.photo,
                    size: 20.sp,
                    color: AppColors.black.withOpacity(0.8),
                  ),
                  SizedBox(
                    width: 16.sp,
                  ),
                  Text(
                    "Gallery",
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> imageActionSheet(
  BuildContext context, {
  required Function() onImageRemoved,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 100.sp,
        padding: EdgeInsets.all(16.sp),
        width: SizerUtil.width,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Are you sure you want to delete?",
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            SizedBox(
              width: 64.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onImageRemoved();
                    context.pop();
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        30.w,
                        20,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                    ),
                  ),
                  child: Text(
                    "Confirm",
                    style: context.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(
                        20.w,
                        20,
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      AppColors.error,
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: context.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> filterSheet(
  BuildContext context,
) {
  return showMaterialModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: context.height / 3,
        padding: EdgeInsets.symmetric(
          vertical: 8.sp,
          horizontal: 12.sp,
        ),
        width: SizerUtil.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.sp),
            topRight: Radius.circular(16.sp),
          ),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            final status = ref.watch(filterVehicleListProvider);
            final read = ref.read(filterVehicleListProvider.notifier);
            return ListView(
              children: [
                Text(
                  "Filter list by",
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: context.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(0.9),
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 64.sp,
                ),
                RadioListTile<VehicleStatusType>(
                  hoverColor: AppColors.primary.shade100,
                  title: Text(
                    "Pending",
                    style: context.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  value: VehicleStatusType.pending,
                  onChanged: (val) {
                    read.onFilter(
                      status: val!,
                    );
                  },
                  groupValue: status,
                ),
                RadioListTile<VehicleStatusType>(
                  hoverColor: AppColors.primary.shade100,
                  title: Text(
                    "Rejected",
                    style: context.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  value: VehicleStatusType.rejected,
                  onChanged: (val) {
                    read.onFilter(
                      status: val!,
                    );
                  },
                  groupValue: status,
                ),
                RadioListTile<VehicleStatusType>(
                  hoverColor: AppColors.primary.shade100,
                  title: Text(
                    "Approved",
                    style: context.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.black.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  value: VehicleStatusType.approved,
                  onChanged: (val) {
                    read.onFilter(
                      status: val!,
                    );
                  },
                  groupValue: status,
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
