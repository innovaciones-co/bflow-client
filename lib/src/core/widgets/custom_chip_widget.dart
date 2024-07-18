import 'package:bflow_client/src/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomChipWidget extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomChipWidget({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, bottom: 2, right: 8, left: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: textColor ?? AppColor.darkGrey, // THIS
        ),
      ),
    );
  }
}
