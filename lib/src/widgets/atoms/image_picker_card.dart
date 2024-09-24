// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/extensions/context.dart';
import 'image_picker_sheet.dart';

// ignore: must_be_immutable
class ImagePickerCard extends StatefulWidget {
  ImagePickerCard({
    super.key,
    required this.onImagePicked,
    required this.onImageDelete,
    required this.imagePath,
    this.imageSrc,
    this.readOnly = false,
  });
  final Function(XFile imageFile) onImagePicked;
  final Function() onImageDelete;
  File? imagePath;
  String? imageSrc;
  bool? readOnly;

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard>
    with AutomaticKeepAliveClientMixin<ImagePickerCard> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DottedBorder(
      radius: Radius.circular(5.sp),
      color: AppColors.greyDark,
      borderType: BorderType.RRect,
      strokeWidth: 1.5,
      dashPattern: const [4, 2],
      padding: EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: widget.imagePath != null || widget.imageSrc != null
            ? AbsorbPointer(
                absorbing: widget.readOnly!,
                child: InkWell(
                  onTap: () async {
                    if (!widget.readOnly!) {
                      if (widget.imageSrc != null && widget.imagePath == null) {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          widget.onImagePicked(image);
                        }
                      }
                      if (widget.imagePath != null) {
                        await imageActionSheet(
                          context,
                          onImageRemoved: () {
                            widget.onImageDelete();
                          },
                        );
                      }
                    }
                  },
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(5.sp),
                    child: widget.imageSrc != null &&
                                widget.imagePath != null ||
                            widget.imagePath != null
                        ? Image.file(
                            widget.imagePath!,
                            repeat: ImageRepeat.noRepeat,
                            height: context.height,
                            width: context.width,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                Icons.error,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : Image.network(
                            widget.imageSrc!,
                            repeat: ImageRepeat.noRepeat,
                            height: context.height,
                            width: context.width,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                Icons.error,
                                size: 50,
                                color: Colors.red,
                              ),
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress != null) {
                                return Shimmer.fromColors(
                                  baseColor:
                                      AppColors.greyLight.withOpacity(0.4),
                                  highlightColor: AppColors.white,
                                  child: Container(
                                    color: AppColors.greyDark,
                                  ),
                                );
                              }
                              return child;
                            },
                          ),
                  ),
                ),
              )
            : InkWell(
                onTap: () async {
                  if (!widget.readOnly!) {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      widget.onImagePicked(image);
                    }
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 30.sp,
                        color: AppColors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        height: 2.w,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2.0,
                          ),
                          child: Text(
                            "Upload Image",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
