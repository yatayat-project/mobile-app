import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';
import '../../core/utils/assets_string.dart';
import '../../features/profile/presentation/profile.dart';
import '../../features/vehicle_list/presentation/search_controller.dart';

AppBar appBar(
  BuildContext context,
  GlobalKey<FormBuilderFieldState> textFieldKey,
) {
  return AppBar(
    toolbarHeight: 116.sp,
    backgroundColor: AppColors.primary,
    leadingWidth: 60.sp,
    leading: Padding(
      padding: EdgeInsets.only(left: 12.sp),
      child: Container(
        height: 60.sp,
        width: 60.sp,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              AssetString.appLogo,
            ),
          ),
        ),
      ),
    ),
    title: Container(
      margin: EdgeInsets.only(left: 4.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Vechicle App",
            style: context.displayLarge!.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 1.sp,
          ),
          Text(
            "Vechicle service at your finter tips",
            style: context.bodyMedium!.copyWith(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
        onPressed: () async {
          context.push(Profile.routeName);
        },
        icon: const Icon(
          Icons.person,
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size(
        context.width,
        0,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.0.sp,
          right: 12.0.sp,
          bottom: 8.sp,
          top: 8.sp,
        ),
        child: Consumer(
          builder: (context, ref, child) {
            String value = ref.watch(searchProvider);
            return FormBuilderTextField(
              key: textFieldKey,
              name: 'search',
              onSubmitted: (val) {
                if (val != null) {
                  ref.read(searchProvider.notifier).setSearchQuery(query: val);
                }
              },
              keyboardType: TextInputType.number,
              style: context.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.9),
                fontSize: 16,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 24,
                ),
                suffixIcon: value.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          ref.read(searchProvider.notifier).clear();
                          textFieldKey.currentState?.didChange(null);
                        },
                        icon: const Icon(
                          Icons.clear_outlined,
                        ),
                      )
                    : null,
                hintText: "Search by vehicle no.",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                hintStyle: context.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black.withOpacity(0.9),
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}
