import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/dialog_widget.dart';
import '../widgets/left_dialog_widget.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isSmallTablet =>
      MediaQuery.of(this).size.width < 650.0 &&
      MediaQuery.of(this).size.width > 500.0;

  bool get isTablet =>
      MediaQuery.of(this).size.width <= 1024.0 &&
      MediaQuery.of(this).size.width >= 650.0;

  bool get isDesktop => MediaQuery.of(this).size.width > 1024.0;

  bool get isSmall =>
      MediaQuery.of(this).size.width < 850.0 &&
      MediaQuery.of(this).size.width >= 560.0;

  bool get isLargeDesktop => MediaQuery.of(this).size.width > 1440.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;

  // text styles

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;
  TextStyle? get bodyExtraSmall =>
      bodySmall?.copyWith(fontSize: 10, height: 1.6, letterSpacing: .5);
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get dividerTextSmall => bodySmall?.copyWith(
      letterSpacing: 0.5, fontWeight: FontWeight.w700, fontSize: 12.0);
  TextStyle? get dividerTextLarge => bodySmall?.copyWith(
      letterSpacing: 1.5,
      fontWeight: FontWeight.w700,
      fontSize: 13.0,
      height: 1.23);

  // Theme data

  ThemeData get theme => Theme.of(this);

  // colors

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get cardColor => Theme.of(this).cardColor;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get background => Theme.of(this).colorScheme.surface;

  // custome theme extensions, You must have to create theme extensions first
  // you can use them with shortcuts as well
  // Gradient get vertical =>
  //     Theme.of(this).extension<AppThemeExtension>()!.vertical;

  // Gradient get horizontal =>
  //     Theme.of(this).extension<AppThemeExtension>()!.horizontal;

  // Color get extraLightGrey =>
  //     Theme.of(this).extension<AppThemeExtension>()!.extraLightGrey;

  // Color get lightGrey =>
  //     Theme.of(this).extension<AppThemeExtension>()!.lightGrey;

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

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      String message) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        // backgroundColor: primary,
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showAlert(
      {required String message, AlertType type = AlertType.info}) {
    Color bgColor = _getBgColor(type);

    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: bgColor,
        margin: EdgeInsets.only(
            bottom: 40, left: this.width * 0.3, right: this.width * 0.3),
      ),
    );
  }

  Color _getBgColor(AlertType type) {
    return switch (type) {
      AlertType.info => AppColor.blue,
      AlertType.success => AppColor.green,
      AlertType.warning => AppColor.orange,
      AlertType.error => AppColor.red,
    };
  }

  Future<bool?> showToast({
    required String message,
    AlertType type = AlertType.info,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 1,
      backgroundColor: _getBgColor(type),
      textColor: Colors.white,
    );
  }

  Future<void> showLeftDialog(String title, Widget child) {
    return showDialog<void>(
      context: this,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return LeftDialogWidget(
          title: title,
          child: child,
        );
      },
    );
  }

  Future<void> showModal(String title, List<Widget> children) {
    return showDialog<void>(
      context: this,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return DialogWidget(
          title: title,
          children: children,
        );
      },
    );
  }

  Future<void> showCustomModal(Widget child) {
    return showDialog<void>(
      context: this,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
