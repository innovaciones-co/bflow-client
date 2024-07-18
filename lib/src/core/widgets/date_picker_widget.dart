import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime?)? onChange;
  final String? label;
  final String? Function(String?)? validator;
  final DateTime? initialValue;
  final bool? editOnTable;

  const DatePickerWidget({
    super.key,
    this.onChange,
    this.label = "Date",
    this.validator,
    this.initialValue,
    this.editOnTable = false,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      if (widget.editOnTable!) {
        _dateController.text = widget.initialValue!.toMonthDate();
      } else {
        _dateController.text = widget.initialValue.toString().split(" ")[0];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.editOnTable!
        ? TextFormField(
            controller: _dateController,
            readOnly: true,
            validator: widget.validator,
            onTap: () {
              _selectDate(context);
            },
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              filled: false,
              contentPadding:
                  EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(widget.label!),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.date_range_outlined),
                  hintText: "YYYY-MM-DD",
                ),
                readOnly: true,
                validator: widget.validator,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ],
          );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: widget.initialValue ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (datePicked != null) {
      setState(() {
        if (widget.editOnTable!) {
          _dateController.text = datePicked.toMonthDate();
        } else {
          _dateController.text = datePicked.toString().split(" ")[0];
        }
      });

      if (widget.onChange != null) {
        widget.onChange!(datePicked);
      }
    }
  }
}
