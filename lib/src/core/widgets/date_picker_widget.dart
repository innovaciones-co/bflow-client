import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final TextEditingController dateController;
  final String label;

  const DatePickerWidget({
    super.key,
    required this.dateController,
    required this.label,
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
          controller: dateController,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.date_range_outlined),
            hintText: "YYYY-MM-DD",
          ),
          readOnly: true,
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
    if (datePicked != null) {
      dateController.text = datePicked.toString().split(" ")[0];
    }
  }
}
