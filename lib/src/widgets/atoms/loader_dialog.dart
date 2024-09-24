import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../config/themes/colors.dart';
import '../../core/utils/constants.dart';
import '../../features/vechicle_document_onboarding/controller/document_onboarding_ctrl.dart';

void screenLoader() {
  showDialog(
    barrierDismissible: false,
    context: currentContext,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {},
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
          scrollable: true,
          titlePadding: const EdgeInsets.all(15),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 140.0,
            vertical: 0.0,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.end,
          content: const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.primary,
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 4,
            ),
          ),
        ),
      );
    },
  );
}

void imageUploadProgress() {
  showDialog(
    barrierDismissible: false,
    context: currentContext,
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {},
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
          scrollable: true,
          titlePadding: const EdgeInsets.all(15),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 130.0,
            vertical: 0.0,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.end,
          content: Center(
            child: Consumer(
              builder: (context, ref, child) {
                int progress =
                    ref.watch(documentNotifierProvider).uploadProgress;
                int total = ref.watch(documentNotifierProvider).total;

                return CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 6.0,
                  animation: true,
                  percent: progress / total,
                  center: Text(
                    "${(progress / total * 100).toStringAsFixed(1)}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: AppColors.primary,
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
