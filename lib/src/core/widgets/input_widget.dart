import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final bool obscureText;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Iterable<String>? autofillHints;
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
    this.onFieldSubmitted,
    this.autofillHints,
    this.validator,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool hidden = true;

  @override
  void initState() {
    super.initState();
    hidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(widget.label),
        ),
        const SizedBox(height: 5),
        TextFormField(
          autofillHints: widget.autofillHints,
          onChanged: widget.onChanged,
          validator: widget.validator,
          obscureText: widget.obscureText ? hidden : false,
          initialValue: widget.initialValue,
          enableSuggestions: widget.obscureText ? false : true,
          autocorrect: widget.obscureText ? false : true,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColor.grey,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.red,
              ),
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    icon: Icon(
                      hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null,
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
