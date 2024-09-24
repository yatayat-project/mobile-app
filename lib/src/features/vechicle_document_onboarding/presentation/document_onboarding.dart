import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../injector.dart';
import '../../../widgets/atoms/image_picker_card.dart';
import '../../../widgets/atoms/input_field.dart';
import '../controller/document_onboarding_ctrl.dart';

class DocumentOnboarding extends ConsumerStatefulWidget {
  static const routeName = "/document-onboarding";
  const DocumentOnboarding({super.key});

  @override
  ConsumerState<DocumentOnboarding> createState() => DocumentOnboardingState();
}

class DocumentOnboardingState extends ConsumerState<DocumentOnboarding> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final notifier = ref.read(documentNotifierProvider.notifier);
    final listenableRef = ref.watch(documentNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.white,
            size: 20.sp,
          ),
        ),
        centerTitle: false,
        title: const Text("Upload documents"),
      ),
      body: ListView.builder(
        itemCount: ref.read(documentNotifierProvider).documentKeys.length,
        padding: EdgeInsets.only(
          top: 12.sp,
          left: 16.sp,
          bottom: 80.sp,
          right: 16.sp,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String documentKey =
              ref.read(documentNotifierProvider).documentKeys[index]["slug"];
          String label =
              ref.read(documentNotifierProvider).documentKeys[index]["name"];
          Key key = Key(
            ref
                .read(documentNotifierProvider)
                .documentKeys[index]["id"]
                .toString(),
          );

          File? getImage() {
            if (ref
                .watch(documentNotifierProvider)
                .documentFile
                .containsKey(documentKey)) {
              return File(
                ref
                    .watch(documentNotifierProvider)
                    .documentFile[documentKey]!
                    .path,
              );
            }
            return null;
          }

          return Padding(
            padding: index == 11
                ? EdgeInsets.only(
                    top: 8.sp,
                    left: 0,
                    bottom: 40.sp,
                    right: 0,
                  )
                : EdgeInsets.only(
                    top: 8.sp,
                    left: 0,
                    bottom: 4.sp,
                    right: 0,
                  ),
            child: InputField(
              label: label,
              required: true,
              labelStyle: context.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.9),
                fontSize: 16,
              ),
              child: ImagePickerCard(
                key: key,
                imagePath: getImage(),
                onImageDelete: () {
                  ref
                      .read(documentNotifierProvider.notifier)
                      .remove(documentKey);
                },
                onImagePicked: (imageFile) {
                  ref
                      .read(documentNotifierProvider.notifier)
                      .add({documentKey: imageFile});
                },
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: kBottomNavigationBarHeight + 14,
        decoration: BoxDecoration(
          color: AppColors.primary.shade100,
        ),
        width: context.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
          child: ElevatedButton(
            onPressed: () {
              if (!listenableRef.isImageUploading) {
                notifier.onSubmit();
              }
            },
            child: Text(
              "Submit",
              style: context.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
