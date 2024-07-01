import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class DropdownControllerWidget<T> extends StatefulWidget {
  final String? label;
  final EdgeInsets labelPadding;
  final List<T> items;
  final ValueChanged<T>? onChanged;
  final String Function(T) getLabel;
  final String? Function(T?)? validator;
  final T? currentItem;
  final bool? editOnTable;

  const DropdownControllerWidget({
    super.key,
    this.label = "",
    this.items = const [],
    this.onChanged,
    required this.getLabel,
    this.validator,
    this.currentItem,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.editOnTable = false,
  });

  @override
  State<DropdownControllerWidget<T>> createState() =>
      _DropdownControllerWidgetState<T>();
}

class _DropdownControllerWidgetState<T>
    extends State<DropdownControllerWidget<T>> {
  T? _currentItem;

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    /* setState(() {
      _controller.text =
          _currentItem != null ? widget.getLabel(_currentItem as T) : '';
    }); */

    setState(() {
      if (widget.items.isNotEmpty) {
        _currentItem = widget.currentItem ?? widget.items.first;
        if (widget.onChanged != null && _currentItem != null) {
          widget.onChanged!(_currentItem as T);
        }
      }
    });
  }

  @override
  void didUpdateWidget(DropdownControllerWidget<T> oldWidget) {
    if (this._currentItem != widget.currentItem) {
      setState(() {
        this._currentItem = widget.currentItem;

        _controller.text =
            _currentItem != null ? widget.getLabel(_currentItem as T) : '';
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.editOnTable!
        ? DropdownMenu<T>(
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: InputBorder.none,
              filled: false,
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            ),
            controller: _controller,
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.all(AppColor.white),
              surfaceTintColor: MaterialStateProperty.all(AppColor.grey),
            ),
            expandedInsets: EdgeInsets.zero,
            trailingIcon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 15,
            ),
            selectedTrailingIcon: const Icon(
              Icons.keyboard_arrow_up_outlined,
              size: 15,
            ),
            initialSelection: _currentItem,
            onSelected: (T? value) {
              if (widget.onChanged != null && value != null) {
                widget.onChanged!(value);
              }
              setState(() {
                if (value != null) {
                  _currentItem = value;
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
                ? widget.validator!(_currentItem)
                : null,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.label != null
                  ? Padding(
                      padding: widget.labelPadding,
                      child: Text(widget.label!),
                    )
                  : const SizedBox.shrink(),
              widget.label != null
                  ? const SizedBox(height: 5)
                  : const SizedBox.shrink(),
              DropdownMenu<T>(
                controller: _controller,
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.white),
                  surfaceTintColor: MaterialStateProperty.all(AppColor.grey),
                ),
                expandedInsets: EdgeInsets.zero,
                trailingIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                selectedTrailingIcon:
                    const Icon(Icons.keyboard_arrow_up_outlined),
                initialSelection: _currentItem,
                onSelected: (T? value) {
                  if (widget.onChanged != null && value != null) {
                    widget.onChanged!(value);
                  }
                  setState(() {
                    if (value != null) {
                      _currentItem = value;
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
                    ? widget.validator!(_currentItem)
                    : null,
              ),
            ],
          );
  }
}
