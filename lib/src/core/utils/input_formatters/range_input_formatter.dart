import 'package:flutter/services.dart';

class RangeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Extract the numeric value from the input string
    String newText = newValue.text;
    double? value = double.tryParse(newText);

    if (value == null || value < 0) {
      // If not a valid number or less than 0, set to 0
      value = 0;
    } else if (value > 100) {
      // If greater than 100, set to 100
      value = 100;
    }

    // Convert the value back to string
    String formattedValue = value.toString();

    // Return the new TextEditingValue with the formatted string
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
