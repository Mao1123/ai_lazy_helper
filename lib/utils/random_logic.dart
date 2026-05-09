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

  // 获取季节性食物
  static List<String> _getSeasonalFoods() {
    switch (TimeLogic.season) {
      case Season.spring:
        return springFoods;
      case Season.summer:
        return summerFoods;
      case Season.autumn:
        return autumnFoods;
      case Season.winter:
        return winterFoods;
    }
  }

  // 获取季节性活动
  static List<String> _getSeasonalActivities() {
    switch (TimeLogic.season) {
      case Season.spring:
        return springActivities;
      case Season.summer:
        return summerActivities;
      case Season.autumn:
        return autumnActivities;
      case Season.winter:
        return winterActivities;
    }
  }

  static String recommendFood() {
    final tod = TimeLogic.timeOfDay;
    final isLateNight = TimeLogic.isLateNight;
    final isHolidayMode = TimeLogic.isHolidayMode;
    final seasonalFoods = _getSeasonalFoods();

    List<String> pool;

    if (isLateNight) {
      pool = _weightedPick(
        base: lateNightFoods,
        weighted: [...lateNightFoods, ...seasonalFoods],
        weightRatio: 0.8,
      );
    } else if (isHolidayMode) {
      // 节假日/周末：偏向聚餐和季节性食物
      pool = _weightedPick(
        base: [...dinnerFoods, ...holidayFoods],
        weighted: [...seasonalFoods, '火锅', '烧烤', '烤肉', '小龙虾'],
        weightRatio: 0.6,
      );
    } else {
      switch (tod) {
        case AppTimeOfDay.morning:
          pool = _weightedPick(
            base: breakfastFoods,
            weighted: seasonalFoods,
            weightRatio: 0.2,
          );
        case AppTimeOfDay.lunch:
          pool = _weightedPick(
            base: lunchFoods,
            weighted: [...seasonalFoods, '外卖随便点', '快餐', '公司食堂'],
            weightRatio: 0.3,
          );
        case AppTimeOfDay.afternoon:
          pool = _weightedPick(
            base: afternoonFoods,
            weighted: seasonalFoods,
            weightRatio: 0.3,
          );
        case AppTimeOfDay.dinner:
          pool = _weightedPick(
            base: dinnerFoods,
            weighted: seasonalFoods,
            weightRatio: 0.4,
          );
        case AppTimeOfDay.lateNight:
          pool = lateNightFoods;
      }
    }

    return _pick(pool);
  }

  static String recommendActivity() {
    final isLateNight = TimeLogic.isLateNight;
    final isHolidayMode = TimeLogic.isHolidayMode;
    final seasonalActivities = _getSeasonalActivities();

    if (isLateNight) {
      return _weightedPick(
        base: lateNightActivities,
        weighted: seasonalActivities,
        weightRatio: 0.3,
      ).let(_pick);
    }
    if (isHolidayMode) {
      return _weightedPick(
        base: [...weekendActivities, ...holidayActivities],
        weighted: seasonalActivities,
        weightRatio: 0.5,
      ).let(_pick);
    }
    return _weightedPick(
      base: weekdayActivities,
      weighted: seasonalActivities,
      weightRatio: 0.2,
    ).let(_pick);
  }

  static String recommendFoodQuote() {
    final quotes = <String>[];

    // 基础食物吐槽
    quotes.addAll(foodQuotes);

    // 通用吐槽
    quotes.addAll(generalQuotes);

    // 根据时间添加
    if (TimeLogic.isLateNight) {
      quotes.addAll(lateNightQuotes);
    } else if (TimeLogic.isHolidayMode) {
      quotes.addAll(weekendQuotes);
    } else {
      quotes.addAll(weekdayQuotes);
    }

    // 根据季节添加
    switch (TimeLogic.season) {
      case Season.spring:
        quotes.addAll(springQuotes);
      case Season.summer:
        quotes.addAll(summerQuotes);
      case Season.autumn:
        quotes.addAll(autumnQuotes);
      case Season.winter:
        quotes.addAll(winterQuotes);
    }

    // 根据节日添加
    if (TimeLogic.isHoliday) {
      quotes.addAll(holidayQuotes);
      if (TimeLogic.isValentines) quotes.addAll(valentineQuotes);
      if (TimeLogic.isHalloween) quotes.addAll(halloweenQuotes);
    }

    return _pick(quotes);
  }

  static String recommendActivityQuote() {
    final quotes = <String>[];

    // 基础活动吐槽
    quotes.addAll(activityQuotes);

    // 通用吐槽
    quotes.addAll(generalQuotes);

    // 根据时间添加
    if (TimeLogic.isLateNight) {
      quotes.addAll(lateNightQuotes);
    } else if (TimeLogic.isHolidayMode) {
      quotes.addAll(weekendQuotes);
    } else {
      quotes.addAll(weekdayQuotes);
    }

    // 根据季节添加
    switch (TimeLogic.season) {
      case Season.spring:
        quotes.addAll(springQuotes);
      case Season.summer:
        quotes.addAll(summerQuotes);
      case Season.autumn:
        quotes.addAll(autumnQuotes);
      case Season.winter:
        quotes.addAll(winterQuotes);
    }

    // 根据节日添加
    if (TimeLogic.isHoliday) {
      quotes.addAll(holidayQuotes);
      if (TimeLogic.isValentines) quotes.addAll(valentineQuotes);
      if (TimeLogic.isHalloween) quotes.addAll(halloweenQuotes);
    }

    return _pick(quotes);
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

// 扩展方法，让 List 可以用 let 链式调用
extension _ListExtension<T> on List<T> {
  R let<R>(R Function(List<T>) fn) => fn(this);
}
