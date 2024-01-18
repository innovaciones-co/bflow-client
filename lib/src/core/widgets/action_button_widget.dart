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

  const ActionButtonWidget({
    super.key,
    required this.onPressed,
    required this.type,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.foregroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.textButton:
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(foregroundColor),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          ),
          child: Row(
            children: [
              icon != null ? Icon(icon, size: 18) : const SizedBox(),
              icon != null ? const SizedBox(width: 6) : const SizedBox(),
              Text(title),
            ],
          ),
        );
      case ButtonType.elevatedButton:
        return ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 18, horizontal: 15)),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            foregroundColor: MaterialStateProperty.all(foregroundColor),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          ),
          child: Row(
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
