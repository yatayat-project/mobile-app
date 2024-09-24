import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';

class CategoryButton extends StatelessWidget {
  CategoryButton({
    super.key,
    required this.isActive,
    required this.onClick,
    required this.label,
    this.showShape = true,
  });
  final bool isActive;
  final Function() onClick;
  final String label;
  bool? showShape;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
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
          return isActive ? AppColors.error.withOpacity(0.8) : AppColors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: showShape!
                ? BorderRadius.circular(50.0.sp)
                : BorderRadius.circular(8.0.sp),
            side: BorderSide(
              color: AppColors.primary.withOpacity(0.5),
              width: 2.0,
            ),
          ),
        ),
      ),
      child: Text(
        label,
        style: context.bodyMedium!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isActive ? AppColors.white : AppColors.black.withOpacity(0.8),
          height: 1,
        ),
      ),
    );
  }
}
