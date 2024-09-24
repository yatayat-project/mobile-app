import 'package:flash/flash.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        Colors,
        Container,
        CrossAxisAlignment,
        Flexible,
        FontWeight,
        Icon,
        IconData,
        Icons,
        MediaQuery,
        Row,
        ScaffoldMessenger,
        SingleChildScrollView,
        Size,
        SizedBox,
        SnackBar,
        Text,
        TextStyle,
        Theme,
        ThemeData,
        Widget,
        Wrap,
        showModalBottomSheet;
import 'package:flutter/src/widgets/basic.dart';
import 'package:go_router/go_router.dart';

import '../../config/themes/colors.dart';

extension BuildContextEntension<T> on BuildContext {
  /*------------------ go router --------------*/
  GoRouter get router => GoRouter.of(this);

  GoRouterState get routerState => GoRouterState.of(this);

  /*------------------ size --------------*/

  Size get size => MediaQuery.of(this).size;

  double get width => size.width;

  double get height => size.height;

  /*------------------ theme --------------*/
  ThemeData get theme => Theme.of(this);

  /*------------------ text styles --------------*/

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  /*------------------ Theme colors --------------*/

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.background;

/*------------------ custom text style  --------------*/
  TextStyle? get languageButtonStyle => this
      .bodySmall
      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold);

  /*------------------ bottom sheet and snackbar  --------------*/

  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }

  snackBar({
    required IconData icon,
    required String message,
    required Color color,
  }) {
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    message,
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: color,
        ),
      );
  }

  Future<T?> showSuccess(
    String message,
  ) {
    return showFlash(
      duration: const Duration(seconds: 4),
      builder: (context, controller) => FlashBar(
        behavior: FlashBehavior.floating,
        controller: controller,
        position: FlashPosition.top,
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          color: Colors.white,
        ),
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
        ),
        iconColor: AppColors.white,
        backgroundColor: Colors.green,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
      ),
      context: this,
    );
  }

  Future<T?> showError(String message) {
    return showFlash(
      duration: const Duration(seconds: 5),
      builder: (context, controller) => FlashBar(
        position: FlashPosition.top,
        behavior: FlashBehavior.floating,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        icon: const Icon(
          Icons.info_outline,
          color: AppColors.white,
        ),
        controller: controller,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
        backgroundColor: AppColors.error,
      ),
      context: this,
    );
  }
}
