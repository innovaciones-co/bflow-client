import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  textButton,
  elevatedButton,
}

class ActionButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final ButtonType type;
  final String title;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? paddingHorizontal;
  final double? paddingVertical;

  ActionButtonWidget({
    super.key,
    required this.onPressed,
    required this.type,
    required this.title,
    this.icon,
    this.backgroundColor,
    foregroundColor,
    this.paddingHorizontal,
    this.paddingVertical,
  }) : foregroundColor = foregroundColor ?? AppColor.blue;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.textButton:
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: paddingVertical ?? 0,
                horizontal: paddingHorizontal ?? 5)),
            overlayColor:
                MaterialStateProperty.all(foregroundColor?.withOpacity(0.05)),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(foregroundColor),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          ),
          child: Row(
            children: [
              icon != null ? Icon(icon, size: 18) : const SizedBox(),
              icon != null ? const SizedBox(width: 6) : const SizedBox(),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: paddingVertical ?? 18,
                horizontal: paddingHorizontal ?? 15)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(foregroundColor),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Icon(icon, size: 18) : const SizedBox(),
              icon != null ? const SizedBox(width: 6) : const SizedBox(),
              Text(title),
            ],
          ),
        );
    }
  }
}
