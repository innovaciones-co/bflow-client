extension DateUtils on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBetweenDates(DateTime startDate, DateTime endDate) {
    if (compareTo(startDate) < 0) {
      return false;
    }

    if (compareTo(endDate) > 0) {
      return false;
    }

    return true;
  }

  int daysDifference(DateTime other) {
    final difference = this.difference(other);
    return difference.inDays.abs();
  }

  int weeksBetween(DateTime other) {
    DateTime startDate = this;
    if (isAfter(other)) {
      final temp = this;
      startDate = other;
      other = temp;
    }

    final days = other.difference(startDate).inDays;
    final weeks = (days / 7).floor();
    final remainingDays = days % 7;

    return (remainingDays > 0) ? weeks + 1 : weeks;
  }
}
