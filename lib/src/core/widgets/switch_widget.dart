import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String? title;
  final bool value;
  final void Function(bool) onChanged;

  const SwitchWidget({
    super.key,
    this.title,
    required this.value,
    required this.onChanged,
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
              value: value,
              onChanged: onChanged,
            ),
          ),
        ),
        title != null ? const SizedBox(width: 5) : const SizedBox.shrink(),
        title != null ? Text(title!) : const SizedBox.shrink(),
      ],
    );
  }
}
