import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatefulWidget {
  final String? label;
  final List<T> items;
  final ValueChanged<T>? onChanged;
  final String Function(T) getLabel;
  final String? Function(T?)? validator;
  final T? initialValue;

  const DropdownWidget({
    super.key,
    this.label,
    this.items = const [],
    this.onChanged,
    required this.getLabel,
    this.validator,
    this.initialValue,
  });

  @override
  State<DropdownWidget<T>> createState() => _DropdownWidgetState<T>();
}

class _DropdownWidgetState<T> extends State<DropdownWidget<T>> {
  T? dropdownValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.items.isNotEmpty) {
        dropdownValue = widget.initialValue ?? widget.items.first;
        if (widget.onChanged != null && dropdownValue != null) {
          widget.onChanged!(dropdownValue as T);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(widget.label!),
              )
            : const SizedBox.shrink(),
        widget.label != null
            ? const SizedBox(height: 5)
            : const SizedBox.shrink(),
        DropdownMenu<T>(
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(AppColor.white),
            surfaceTintColor: MaterialStateProperty.all(AppColor.grey),
          ),
          expandedInsets: EdgeInsets.zero,
          trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined),
          selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_outlined),
          initialSelection: dropdownValue,
          onSelected: (T? value) {
            if (widget.onChanged != null && value != null) {
              widget.onChanged!(value);
            }
            setState(() {
              if (value != null) {
                dropdownValue = value;
              }
            });
          },
          dropdownMenuEntries: widget.items.map((T value) {
            String label = widget.getLabel(value);

            return DropdownMenuEntry<T>(
              value: value,
              label: label,
            );
          }).toList(),
          errorText: widget.validator != null
              ? widget.validator!(dropdownValue)
              : null,
        ),
      ],
    );
  }
}
