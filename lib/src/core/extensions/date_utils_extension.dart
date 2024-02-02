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
}
