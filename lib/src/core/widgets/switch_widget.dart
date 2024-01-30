import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String? title;

  const SwitchWidget({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 28,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch.adaptive(
              activeColor: AppColor.blue,
              activeTrackColor: AppColor.blue,
              inactiveThumbColor: AppColor.white,
              inactiveTrackColor: AppColor.grey,
              value: false,
              onChanged: null,
            ),
          ),
        ),
        title != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
        title != null ? Text(title!) : const SizedBox.shrink(),
      ],
    );
  }
}
