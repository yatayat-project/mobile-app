import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../widgets/atoms/image_picker_card.dart';
import '../../../widgets/atoms/input_field.dart';
import '../../vehicle_list/modal/vehilce_list_response.dart';
import '../controller/document_onboarding_ctrl.dart';
import 'gallery_image_view.dart';

class DocumentUpdate extends ConsumerStatefulWidget {
  final List<Document> rejectedDoc;
  final bool readOnlyMode;
  static const routeName = "/document-update";
  const DocumentUpdate({
    super.key,
    required this.readOnlyMode,
    required this.rejectedDoc,
  });

  @override
  ConsumerState<DocumentUpdate> createState() => DocumentUpdateState();
}

class DocumentUpdateState extends ConsumerState<DocumentUpdate> {
  late List<Document> docList;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(documentNotifierProvider.notifier).clearRejectedDocument();
    });

    docList = widget.rejectedDoc;
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
        title: Text(
          "Update document",
          style: context.displayLarge!.copyWith(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          widget.readOnlyMode
              ? IconButton(
                  onPressed: () {
                    context.push(GalleryView.routeName, extra: docList);
                  },
                  icon: const Icon(
                    Icons.photo,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: ListView.builder(
        itemCount: docList.length,
        padding: EdgeInsets.only(
          top: 12.sp,
          left: 16.sp,
          bottom: 80.sp,
          right: 16.sp,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Document doc = docList[index];
          String documentKey = docList[index].abhilekhSlug;
          Key key = Key(
            docList[index].id.toString(),
          );

          File? getImage() {
            if (ref
                .watch(documentNotifierProvider)
                .updatedDocumentFile
                .containsKey(documentKey)) {
              return File(
                ref
                    .watch(documentNotifierProvider)
                    .updatedDocumentFile[documentKey]!
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
              label: docList[index].abhilekhName,
              required: true,
              labelStyle: context.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.9),
                fontSize: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImagePickerCard(
                    key: key,
                    imagePath: getImage(),
                    imageSrc: doc.docs,
                    readOnly: widget.readOnlyMode,
                    onImageDelete: () {
                      if (!widget.readOnlyMode) {
                        ref
                            .read(documentNotifierProvider.notifier)
                            .removeRejectedDocument(documentKey);
                      }
                    },
                    onImagePicked: (imageFile) {
                      if (!widget.readOnlyMode) {
                        ref
                            .read(documentNotifierProvider.notifier)
                            .addRejectedDocument({documentKey: imageFile});
                      }
                    },
                  ),
                  doc.rejectionComment != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            "Remark: ${doc.rejectionComment}",
                            style: context.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.error,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: widget.readOnlyMode
          ? const SizedBox.shrink()
          : Container(
              height: kBottomNavigationBarHeight + 14,
              decoration: BoxDecoration(
                color: AppColors.primary.shade100,
              ),
              width: context.width,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(documentNotifierProvider.notifier).onUpdate(
                          vehicleID: docList[0].vehicleId,
                          rejectedDocs: docList.length,
                        );
                  },
                  child: Text(
                    "Update",
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
