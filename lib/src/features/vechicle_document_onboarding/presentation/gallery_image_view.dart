import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../vehicle_list/modal/vehilce_list_response.dart';

class GalleryView extends StatefulWidget {
  static const routeName = "/gallery";
  const GalleryView({super.key, required this.rejectedDoc});
  final List<Document> rejectedDoc;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  late List<Document> docList;
  String initialName = "";
  @override
  void initState() {
    docList = widget.rejectedDoc;
    initialName = docList[0].abhilekhName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document view',
          style: context.displayLarge!.copyWith(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 20.sp),
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.sp,
                  reverse: false,
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      initialName = docList[index].abhilekhName;
                    });
                  },
                  enlargeCenterPage: true,
                ),
                items: docList.map((Document data) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: context.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.sp),
                          child: Transform.scale(
                            scale: 1.2,
                            child: Transform.translate(
                              offset: const Offset(0, 0),
                              child: Image.network(
                                data.docs,
                                repeat: ImageRepeat.noRepeat,
                                filterQuality: FilterQuality.high,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress != null) {
                                    return Shimmer.fromColors(
                                      baseColor:
                                          AppColors.greyLight.withOpacity(0.4),
                                      highlightColor: AppColors.white,
                                      child: Container(
                                        height: 300.sp,
                                        color: AppColors.greyDark,
                                      ),
                                    );
                                  }
                                  return child;
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Text(
                initialName,
                textAlign: TextAlign.center,
                style: context.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.black.withOpacity(0.9),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
