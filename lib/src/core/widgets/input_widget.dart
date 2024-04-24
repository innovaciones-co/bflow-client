import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const InputWidget({
    super.key,
    required this.label,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
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
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColor.grey,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.red,
              ), // Set border color for invalid input
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.red,
              ), // Set border color for invalid input when focused
            ),
          ),
        ),
      ],
    );
  }
}
