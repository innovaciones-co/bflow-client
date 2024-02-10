import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextInputType? keyboardType;

  const InputWidget({
    super.key,
    required this.label,
    this.initialValue,
    this.keyboardType,
    this.obscureText = false,
    this.hintText = "",
    this.onChanged,
    this.validator,
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
        TextFormField(
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          initialValue: initialValue,
          enableSuggestions: obscureText ? false : true,
          autocorrect: obscureText ? false : true,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
