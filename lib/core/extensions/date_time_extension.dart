/// Provides extra functionality for formatting the time.
extension DateTimeExtension on DateTime {
  bool operator <(DateTime other) {
    return millisecondsSinceEpoch < other.millisecondsSinceEpoch;
  }

  bool operator >(DateTime other) {
    return millisecondsSinceEpoch > other.millisecondsSinceEpoch;
  }

  bool operator >=(DateTime other) {
    return millisecondsSinceEpoch >= other.millisecondsSinceEpoch;
  }

  bool operator <=(DateTime other) {
    return millisecondsSinceEpoch <= other.millisecondsSinceEpoch;
  }

  /// Two message events can belong to the same environment. That means that they
  /// don't need to display the time they were sent because they are close
  /// enaugh.
  static const minutesBetweenEnvironments = 5;

  /// Checks if two DateTimes are close enough to belong to the same
  /// environment.
  bool sameEnvironment(DateTime prevTime) {
    return millisecondsSinceEpoch - prevTime.millisecondsSinceEpoch <
        1000 * 60 * minutesBetweenEnvironments;
  }

  /// Returns a simple time String.
  String localizedTimeOfDay() {
    return '${_z(hour % 12 == 0 ? 12 : hour % 12)}:${_z(minute)} ${hour > 11 ? "PM" : "Am"}';
  }

  /// Returns [localizedTimeOfDay()] if the ChatTime is today, the name of the week
  /// day if the ChatTime is this week and a date string else.
  String localizedTimeShort() {
    final now = DateTime.now();

    final sameYear = now.year == year;

    final sameDay = sameYear && now.month == month && now.day == day;

    final sameWeek = sameYear &&
        !sameDay &&
        now.millisecondsSinceEpoch - millisecondsSinceEpoch <
            1000 * 60 * 60 * 24 * 7;

    if (sameDay) {
      return localizedTimeOfDay();
    } else if (sameWeek) {
      switch (weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (sameYear) {
      return "${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}";
    }
    return "${day.toString().padLeft(2, '0')}-${month.toString().padLeft(2, '0')}-${year.toString()}";
  }

  /// If the DateTime is today, this returns [localizedTimeOfDay()], if not it also
  /// shows the date.

  String localizedTime() {
    final now = DateTime.now();

    final sameYear = now.year == year;

    final sameDay = sameYear && now.month == month && now.day == day;

    if (sameDay) return localizedTimeOfDay();
    return "${localizedTimeShort()}, ${localizedTimeOfDay()}";
  }

  static String _z(int i) => i < 10 ? '0${i.toString()}' : i.toString();
}
