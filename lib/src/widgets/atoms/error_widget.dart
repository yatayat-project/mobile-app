import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';

// ignore: must_be_immutable
class ErrorView extends StatelessWidget {
  String? errorText;
  Function()? onRetry;
  ErrorView({super.key, this.errorText, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning,
            color: AppColors.error.withOpacity(0.8),
            size: 40.sp,
          ),
          SizedBox(
            height: 2.sp,
          ),
          Text(
            errorText ?? "An error occurred.",
            style: context.bodyMedium!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              height: 1,
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          onRetry == null
              ? const SizedBox.shrink()
              : ElevatedButton(
                  onPressed: onRetry,
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
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return AppColors.error.withOpacity(0.8);
                    }),
                  ),
                  child: Text(
                    "Retry",
                    style: context.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      height: 1,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
