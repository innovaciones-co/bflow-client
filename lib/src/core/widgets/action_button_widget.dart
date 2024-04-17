import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  textButton,
  elevatedButton,
}

class ActionButtonWidget extends StatelessWidget {
  final bool inProgress;
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
    this.inProgress = false,
  }) : foregroundColor = foregroundColor ?? AppColor.blue;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.textButton:
        return TextButton(
          onPressed: inProgress ? null : onPressed,
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
              inProgress
                  ? Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 10),
                      child: CircularProgressIndicator(
                        color: foregroundColor,
                      ),
                    )
                  : const SizedBox.shrink(),
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
          onPressed: inProgress ? null : onPressed,
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
              inProgress
                  ? Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 10),
                      child: CircularProgressIndicator(
                        color: foregroundColor,
                      ),
                    )
                  : const SizedBox.shrink(),
              icon != null ? Icon(icon, size: 18) : const SizedBox(),
              icon != null ? const SizedBox(width: 6) : const SizedBox(),
              Text(title),
            ],
          ),
        );
    }
  }
}
