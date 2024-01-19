import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String title;
  final bool obscureText;
  final String hintText;

  const InputWidget({
    super.key,
    required this.title,
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
          child: Text(title),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          enableSuggestions: obscureText ? false : true,
          autocorrect: obscureText ? false : true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
