import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';

enum TagEnum {
  approved,
  rejected,
  pending,
  rejectedUpdated,
}

Map<String, Color> tagColors = {
  TagEnum.approved.name: Colors.green,
  TagEnum.rejected.name: AppColors.error,
  TagEnum.pending.name: Colors.green,
  TagEnum.rejectedUpdated.name: const Color.fromARGB(255, 243, 105, 14),
};

class CustomTag extends StatelessWidget {
  const CustomTag({super.key, required this.label, required this.tagEnum});
  final String label;
  final TagEnum tagEnum;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(0.8),
      child: Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0.sp),
          side: BorderSide(color: tagColors[tagEnum.name]!),
        ),
        shadowColor: tagColors[tagEnum.name],
        backgroundColor: tagColors[tagEnum.name],
        label: Text(
          label,
          style: context.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
