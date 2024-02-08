import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime?)? onChange;
  final String label;
  final String? Function(String?)? validator;
  final DateTime? initialValue;

  const DatePickerWidget({
    super.key,
    this.onChange,
    required this.label,
    this.validator,
    this.initialValue,
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
      _dateController.text = widget.initialValue.toString().split(" ")[0];
    }
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
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (widget.onChange != null) {
      widget.onChange!(datePicked);
    }
    if (datePicked != null) {
      _dateController.text = datePicked.toString().split(" ")[0];
    }
  }
}
