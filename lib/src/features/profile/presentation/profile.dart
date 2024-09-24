import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../../config/themes/colors.dart';
import '../../../core/extensions/context.dart';
import '../../../widgets/atoms/category_button.dart';
import '../../../widgets/atoms/error_widget.dart';
import '../../../widgets/molecules/graph.dart';
import '../../authentication/presentation/login_controller.dart';
import '../modal/profile_response.dart';
import 'profile_controller.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});
  static const String routeName = "/profile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProfileData> responseAsync = ref.watch(
      profileControllerProvider,
    );
    return Scaffold(
      appBar: AppBar(),
      body: responseAsync.when(
        data: (data) {
          var profile = data.data.profile;
          return ListView(
            children: [
              Container(
                width: context.width,
                height: context.height / 3.5,
                color: AppColors.primary,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: AppColors.white,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 24.sp,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Text(
                      profile.name,
                      style: context.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          profile.phone,
                          style: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          profile.email,
                          style: context.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.sp,
                    ),
                    CategoryButton(
                      isActive: true,
                      showShape: false,
                      onClick: () async {
                        await ref
                            .read(loginControllerProvider.notifier)
                            .logout();
                      },
                      label: "Logout",
                    ),
                  ],
                ),
              ),
              BarGraphView(
                rejected: data.data.rejectedCount,
                approved: data.data.approvedCount,
                pending: data.data.pendingCount,
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log("error $stackTrace");
          return ErrorView(
            onRetry: () async {
              ref.invalidate(profileControllerProvider);
              try {
                await ref.read(
                  profileControllerProvider.future,
                );
              } catch (e) {}
            },
          );
        },
        loading: () {
          return SizedBox(
            height: context.height,
            width: context.width,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary,
                valueColor: AlwaysStoppedAnimation(Colors.white),
                strokeWidth: 4,
              ),
            ),
          );
        },
      ),
    );
  }
}
