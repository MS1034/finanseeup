class DateHelper {
  static DateTime getStartOfPeriod(Period period) {
    DateTime now = DateTime.now();

    switch (period) {
      case Period.Week:
        return now.subtract(Duration(days: now.weekday - 1));
      case Period.Month:
        return DateTime(now.year, now.month, 1);
      case Period.Quarter:
        int quarter = ((now.month - 1) / 3).floor() + 1;
        return DateTime(now.year, (quarter - 1) * 3 + 1, 1);
      case Period.Year:
        return DateTime(now.year, 1, 1);
      case Period.All:
        return DateTime(
            1970, 1, 1); // A distant past date, you can adjust this as needed
    }
  }

  static DateTime getEndOfPeriod(Period period) {
    DateTime now = DateTime.now();

    switch (period) {
      case Period.Week:
        return now.add(Duration(days: 7 - now.weekday));
      case Period.Month:
        return DateTime(now.year, now.month + 1, 0);
      case Period.Quarter:
        int quarter = ((now.month - 1) / 3).floor() + 1;
        return DateTime(now.year, quarter * 3, 0);
      case Period.Year:
        return DateTime(now.year, 12, 31);
      case Period.All:
        return now; // Use the current date for the end of the "ALL" period
    }
  }
}

enum Period { Week, Month, Year, Quarter, All }
