import 'package:intl/intl.dart';

extension DateTimeFormatExtension on DateTime {
  toDateFormat() => DateFormat('yyyy-MM-dd').format(this);

  toMonthDate() => DateFormat('dd MMM').format(this);

  toMonthAndYear() => DateFormat('MMMM yyyy').format(this);

  toDay() => DateFormat('EEEE').format(this);
}

extension DoubleFormatExtension on double {
  String toPercentage() => "${(this * 100).toStringAsFixed(2)}%";
}

extension CurrencyFormatter on num {
  String toCurrency({String symbol = "\$", int decimalDigits = 2}) {
    final formatter = NumberFormat.currency(
        locale: 'en_AU', decimalDigits: decimalDigits, symbol: symbol);
    return formatter.format(this);
  }
}
