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
              activeColor: Colors.blue,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
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
