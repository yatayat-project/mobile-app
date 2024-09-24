import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../core/extensions/context.dart';
import '../../core/utils/assets_string.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AssetString.onboardingIcon,
          height: 40.sp,
          width: 40.sp,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "Citizen Investment Trust",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
