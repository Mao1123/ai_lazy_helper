enum TimeOfDay { morning, lunch, afternoon, dinner, lateNight }

class TimeLogic {
  static DateTime get now => DateTime.now();

  static int get weekday => now.weekday;

  static int get hour => now.hour;

  static bool get isWeekend => weekday == 6 || weekday == 7;

  static bool get isLateNight => hour >= 21 || hour < 6;

  static TimeOfDay get timeOfDay {
    if (hour >= 6 && hour < 10) return TimeOfDay.morning;
    if (hour >= 10 && hour < 14) return TimeOfDay.lunch;
    if (hour >= 14 && hour < 17) return TimeOfDay.afternoon;
    if (hour >= 17 && hour < 21) return TimeOfDay.dinner;
    return TimeOfDay.lateNight;
  }

  static String get timeOfDayName {
    switch (timeOfDay) {
      case TimeOfDay.morning:
        return '早上';
      case TimeOfDay.lunch:
        return '中午';
      case TimeOfDay.afternoon:
        return '下午';
      case TimeOfDay.dinner:
        return '晚上';
      case TimeOfDay.lateNight:
        return '深夜';
    }
  }

  static String get weekdayName {
    const names = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return names[weekday - 1];
  }
}
