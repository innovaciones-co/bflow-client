extension DateTimeExtensions on DateTime {
  int daysDifference(DateTime other) {
    final difference = this.difference(other);
    return difference.inDays.abs();
  }
}

extension DoubleFormatExtension on double {
  String toPercentage() => "${(this * 100).toStringAsFixed(2)}%";
}
