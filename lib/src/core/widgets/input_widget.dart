import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String hintText;

  const InputWidget({
    super.key,
    required this.label,
    this.obscureText = false,
    this.hintText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(label),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          enableSuggestions: obscureText ? false : true,
          autocorrect: obscureText ? false : true,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
