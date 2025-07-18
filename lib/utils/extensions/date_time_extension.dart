import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension DateTimeExtension on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }

  static String get dayMonthYear => DateFormat('dd MMM yyyy').format(current);

  String getWeekRange() {
    final int startDate = Jiffy.parse(toString()).startOf(Unit.week).date;
    final int endDate = Jiffy.parse(toString()).endOf(Unit.week).date;
    if (startDate > endDate) {
      // different month
      final String startMonth = Jiffy.parse(toString()).startOf(Unit.week).MMM;
      final String endMonthWithYear =
          Jiffy.parse(toString()).endOf(Unit.week).yMMM;

      final int startYear = Jiffy.parse(toString()).startOf(Unit.week).year;
      final int endYear = Jiffy.parse(toString()).endOf(Unit.week).year;

      // also different year
      if (startYear != endYear) {
        return '$startDate $startMonth $startYear - $endDate $endMonthWithYear';
      }

      return '$startDate $startMonth - $endDate $endMonthWithYear';
    } else {
      // same month
      final String monthWithYear =
          Jiffy.parse(toString()).startOf(Unit.week).yMMM;
      return '$startDate - $endDate $monthWithYear';
    }
  }

  String convertToDateTimeFormat() {
    return '${toString().replaceFirst(' ', 'T')}Z';
  }
}
