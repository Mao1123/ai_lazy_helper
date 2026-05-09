enum AppTimeOfDay { morning, lunch, afternoon, dinner, lateNight }
enum Season { spring, summer, autumn, winter }

class TimeLogic {
  static DateTime get now => DateTime.now();

  static int get weekday => now.weekday;

  static int get hour => now.hour;

  static int get month => now.month;

  static int get day => now.day;

  static bool get isWeekend => weekday == 6 || weekday == 7;

  static bool get isLateNight => hour >= 21 || hour < 6;

  static AppTimeOfDay get timeOfDay {
    if (hour >= 6 && hour < 10) return AppTimeOfDay.morning;
    if (hour >= 10 && hour < 14) return AppTimeOfDay.lunch;
    if (hour >= 14 && hour < 17) return AppTimeOfDay.afternoon;
    if (hour >= 17 && hour < 21) return AppTimeOfDay.dinner;
    return AppTimeOfDay.lateNight;
  }

  static String get timeOfDayName {
    switch (timeOfDay) {
      case AppTimeOfDay.morning:
        return '早上';
      case AppTimeOfDay.lunch:
        return '中午';
      case AppTimeOfDay.afternoon:
        return '下午';
      case AppTimeOfDay.dinner:
        return '晚上';
      case AppTimeOfDay.lateNight:
        return '深夜';
    }
  }

  static String get weekdayName {
    const names = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return names[weekday - 1];
  }

  // 季节判断
  static Season get season {
    if (month >= 3 && month <= 5) return Season.spring;
    if (month >= 6 && month <= 8) return Season.summer;
    if (month >= 9 && month <= 11) return Season.autumn;
    return Season.winter;
  }

  static String get seasonName {
    switch (season) {
      case Season.spring:
        return '春天';
      case Season.summer:
        return '夏天';
      case Season.autumn:
        return '秋天';
      case Season.winter:
        return '冬天';
    }
  }

  // 节假日/特殊日期判断
  static bool get isNewYear => month == 1 && day == 1;
  static bool get isSpringFestival => (month == 1 && day >= 20) || (month == 2 && day <= 20);
  static bool get isValentines => month == 2 && day == 14;
  static bool get isWomenDay => month == 3 && day == 8;
  static bool get isMayDay => month == 5 && day >= 1 && day <= 5;
  static bool get isChildrenDay => month == 6 && day == 1;
  static bool get isMidAutumn => month == 9 && day >= 10 && day <= 20;
  static bool get isNationalDay => month == 10 && day >= 1 && day <= 7;
  static bool get isChristmas => month == 12 && day == 25;
  static bool get isHalloween => month == 10 && day == 31;

  static bool get isHoliday =>
      isNewYear ||
      isSpringFestival ||
      isValentines ||
      isWomenDay ||
      isMayDay ||
      isChildrenDay ||
      isMidAutumn ||
      isNationalDay ||
      isChristmas ||
      isHalloween;

  static String get holidayName {
    if (isNewYear) return '元旦';
    if (isSpringFestival) return '春节';
    if (isValentines) return '情人节';
    if (isWomenDay) return '妇女节';
    if (isMayDay) return '劳动节';
    if (isChildrenDay) return '儿童节';
    if (isMidAutumn) return '中秋节';
    if (isNationalDay) return '国庆节';
    if (isChristmas) return '圣诞节';
    if (isHalloween) return '万圣节';
    return '';
  }

  // 是否是周末+节假日的休闲模式
  static bool get isHolidayMode => isWeekend || isHoliday;

  // 完整的日期时间描述
  static String get dateTimeDesc {
    final buffer = StringBuffer();
    buffer.write('$month月$day日');
    buffer.write(' $weekdayName');
    if (isHoliday) {
      buffer.write(' · $holidayName');
    }
    return buffer.toString();
  }
}
