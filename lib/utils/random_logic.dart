import 'dart:math';

import '../data/food_data.dart';
import '../data/activity_data.dart';
import '../data/quote_data.dart';
import '../models/recommend_model.dart';
import 'time_logic.dart';

class RandomLogic {
  static final _random = Random();

  static String _pick(List<String> list) => list[_random.nextInt(list.length)];

  static List<String> _weightedPick({
    required List<String> base,
    required List<String> weighted,
    double weightRatio = 0.5,
  }) {
    final pool = [...base];
    final extraCount = (base.length * weightRatio).round();
    for (var i = 0; i < extraCount; i++) {
      pool.add(weighted[_random.nextInt(weighted.length)]);
    }
    return pool;
  }

  static String recommendFood() {
    final tod = TimeLogic.timeOfDay;
    final isWeekend = TimeLogic.isWeekend;
    final isLateNight = TimeLogic.isLateNight;

    List<String> pool;

    if (isLateNight) {
      pool = _weightedPick(
        base: lateNightFoods,
        weighted: lateNightFoods,
        weightRatio: 0.8,
      );
    } else if (isWeekend) {
      pool = _weightedPick(
        base: dinnerFoods,
        weighted: ['火锅', '烧烤', '烤肉', '小龙虾'],
        weightRatio: 0.5,
      );
    } else {
      switch (tod) {
        case TimeOfDay.morning:
          pool = breakfastFoods;
        case TimeOfDay.lunch:
          pool = _weightedPick(
            base: lunchFoods,
            weighted: ['外卖随便点', '快餐', '公司食堂'],
            weightRatio: 0.3,
          );
        case TimeOfDay.afternoon:
          pool = afternoonFoods;
        case TimeOfDay.dinner:
          pool = dinnerFoods;
        case TimeOfDay.lateNight:
          pool = lateNightFoods;
      }
    }

    return _pick(pool);
  }

  static String recommendActivity() {
    final isWeekend = TimeLogic.isWeekend;
    final isLateNight = TimeLogic.isLateNight;

    if (isLateNight) return _pick(lateNightActivities);
    if (isWeekend) return _pick(weekendActivities);
    return _pick(weekdayActivities);
  }

  static String recommendFoodQuote() {
    if (TimeLogic.isLateNight) return _pick([...lateNightQuotes, ...foodQuotes]);
    if (TimeLogic.isWeekend) return _pick([...weekendQuotes, ...foodQuotes]);
    return _pick([...weekdayQuotes, ...foodQuotes]);
  }

  static String recommendActivityQuote() {
    if (TimeLogic.isLateNight) {
      return _pick([...lateNightQuotes, ...activityQuotes]);
    }
    if (TimeLogic.isWeekend) {
      return _pick([...weekendQuotes, ...activityQuotes]);
    }
    return _pick([...weekdayQuotes, ...activityQuotes]);
  }

  static RecommendResult recommend() {
    return RecommendResult(
      food: recommendFood(),
      activity: recommendActivity(),
      foodQuote: recommendFoodQuote(),
      activityQuote: recommendActivityQuote(),
    );
  }
}
