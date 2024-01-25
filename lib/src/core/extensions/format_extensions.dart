import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  int daysDifference(DateTime other) {
    final difference = this.difference(other);
    return difference.inDays.abs();
  }

  toDateFormat() => DateFormat('yyyy-MM-dd').format(this);
}

extension DoubleFormatExtension on double {
  String toPercentage() => "${(this * 100).toStringAsFixed(2)}%";
}
