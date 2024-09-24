import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Colors,
        LinearProgressIndicator,
        SizedBox,
        StatelessWidget,
        Widget;

import '../../config/themes/colors.dart';

enum LoadingIndicatorType { circular, linear }

class LoadingIndicator extends StatelessWidget {
  late final Map<LoadingIndicatorType, Widget> builder;
  final bool isLoading;
  final double? height;
  final double strokeWidth;
  final double? width;
  final LoadingIndicatorType type;
  final Widget child;

  LoadingIndicator({
    super.key,
    this.height = 20.0,
    this.strokeWidth = 3.0,
    this.width = 20.0,
    this.type = LoadingIndicatorType.circular,
    this.child = const SizedBox(),
    this.isLoading = false,
  }) {
    builder = {
      LoadingIndicatorType.circular: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: strokeWidth,
          backgroundColor: Colors.grey.shade400,
        ),
      ),
      LoadingIndicatorType.linear: const LinearProgressIndicator(
        backgroundColor: AppColors.primary,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? type == LoadingIndicatorType.circular
            ? Center(child: builder[type]!)
            : Align(
                alignment: Alignment.bottomCenter,
                child: builder[type]!,
              )
        : child;
  }
}
