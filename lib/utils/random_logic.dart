import 'dart:math';

import '../data/food_data.dart';
import '../data/activity_data.dart';
import '../data/quote_data.dart';
import '../data/mood_data.dart';
import '../data/movie_data.dart';
import '../data/music_data.dart';
import '../data/book_data.dart';
import '../models/recommend_model.dart';
import '../models/mood_model.dart';
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

  // 获取情绪对应的食物
  static List<String> _getMoodFoods(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return happyFoods;
      case Mood.emo:
        return emoFoods;
      case Mood.lazy:
        return lazyFoods;
      case Mood.crazy:
        return crazyFoods;
    }
  }

  // 获取情绪对应的活动
  static List<String> _getMoodActivities(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return happyActivities;
      case Mood.emo:
        return emoActivities;
      case Mood.lazy:
        return lazyActivities;
      case Mood.crazy:
        return crazyActivities;
    }
  }

  // 获取情绪对应的文案
  static List<String> _getMoodQuotes(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return happyQuotes;
      case Mood.emo:
        return emoQuotes;
      case Mood.lazy:
        return lazyQuotes;
      case Mood.crazy:
        return crazyQuotes;
    }
  }

  static String recommendFood({Mood? mood}) {
    final tod = TimeLogic.timeOfDay;
    final isLateNight = TimeLogic.isLateNight;
    final isHolidayMode = TimeLogic.isHolidayMode;
    final seasonalFoods = _getSeasonalFoods();

    List<String> pool;

    // 如果有情绪，混入情绪食物
    final moodFoods = mood != null ? _getMoodFoods(mood) : <String>[];

    if (isLateNight) {
      pool = _weightedPick(
        base: lateNightFoods,
        weighted: [...lateNightFoods, ...seasonalFoods, ...moodFoods],
        weightRatio: 0.8,
      );
    } else if (isHolidayMode) {
      pool = _weightedPick(
        base: [...dinnerFoods, ...holidayFoods],
        weighted: [...seasonalFoods, ...moodFoods, '火锅', '烧烤', '烤肉', '小龙虾'],
        weightRatio: 0.6,
      );
    } else {
      switch (tod) {
        case AppTimeOfDay.morning:
          pool = _weightedPick(
            base: breakfastFoods,
            weighted: [...seasonalFoods, ...moodFoods],
            weightRatio: 0.3,
          );
        case AppTimeOfDay.lunch:
          pool = _weightedPick(
            base: lunchFoods,
            weighted: [...seasonalFoods, ...moodFoods, '外卖随便点', '快餐', '公司食堂'],
            weightRatio: 0.3,
          );
        case AppTimeOfDay.afternoon:
          pool = _weightedPick(
            base: afternoonFoods,
            weighted: [...seasonalFoods, ...moodFoods],
            weightRatio: 0.3,
          );
        case AppTimeOfDay.dinner:
          pool = _weightedPick(
            base: dinnerFoods,
            weighted: [...seasonalFoods, ...moodFoods],
            weightRatio: 0.4,
          );
        case AppTimeOfDay.lateNight:
          pool = [...lateNightFoods, ...moodFoods];
      }
    }

    return _pick(pool);
  }

  static String recommendActivity({Mood? mood}) {
    final isLateNight = TimeLogic.isLateNight;
    final isHolidayMode = TimeLogic.isHolidayMode;
    final seasonalActivities = _getSeasonalActivities();

    // 如果有情绪，混入情绪活动
    final moodActivities = mood != null ? _getMoodActivities(mood) : <String>[];

    if (isLateNight) {
      return _weightedPick(
        base: lateNightActivities,
        weighted: [...seasonalActivities, ...moodActivities],
        weightRatio: 0.3,
      ).let(_pick);
    }
    if (isHolidayMode) {
      return _weightedPick(
        base: [...weekendActivities, ...holidayActivities],
        weighted: [...seasonalActivities, ...moodActivities],
        weightRatio: 0.5,
      ).let(_pick);
    }
    return _weightedPick(
      base: weekdayActivities,
      weighted: [...seasonalActivities, ...moodActivities],
      weightRatio: 0.3,
    ).let(_pick);
  }

  static String recommendFoodQuote({Mood? mood}) {
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

    // 根据情绪添加
    if (mood != null) {
      quotes.addAll(_getMoodQuotes(mood));
    }

    return _pick(quotes);
  }

  static String recommendActivityQuote({Mood? mood}) {
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

    // 根据情绪添加
    if (mood != null) {
      quotes.addAll(_getMoodQuotes(mood));
    }

    return _pick(quotes);
  }

  // 电影推荐
  static String recommendMovie({Mood? mood}) {
    final timeOfDay = TimeLogic.timeOfDayKey;
    final season = TimeLogic.season.name;

    List<String> pool = [];

    // 根据心情添加
    if (mood != null && moodMovieMap[mood.name] != null) {
      pool.addAll(moodMovieMap[mood.name]!);
    }

    // 根据时段添加
    if (timeMovieMap[timeOfDay] != null) {
      pool.addAll(timeMovieMap[timeOfDay]!);
    }

    // 根据季节添加
    if (seasonMovieMap[season] != null) {
      pool.addAll(seasonMovieMap[season]!);
    }

    // 如果池为空，使用默认列表
    if (pool.isEmpty) {
      pool.addAll(comedyMovies);
      pool.addAll(healingMovies);
    }

    return _pick(pool);
  }

  // 音乐推荐
  static String recommendMusic({Mood? mood}) {
    final timeOfDay = TimeLogic.timeOfDayKey;
    final season = TimeLogic.season.name;

    List<String> pool = [];

    // 根据心情添加
    if (mood != null && moodMusicMap[mood.name] != null) {
      pool.addAll(moodMusicMap[mood.name]!);
    }

    // 根据时段添加
    if (timeMusicMap[timeOfDay] != null) {
      pool.addAll(timeMusicMap[timeOfDay]!);
    }

    // 根据季节添加
    if (seasonMusicMap[season] != null) {
      pool.addAll(seasonMusicMap[season]!);
    }

    // 如果池为空，使用默认列表
    if (pool.isEmpty) {
      pool.addAll(popMusic);
      pool.addAll(healingMusic);
    }

    return _pick(pool);
  }

  // 书籍推荐
  static String recommendBook({Mood? mood}) {
    final timeOfDay = TimeLogic.timeOfDayKey;
    final season = TimeLogic.season.name;

    List<String> pool = [];

    // 根据心情添加
    if (mood != null && moodBookMap[mood.name] != null) {
      pool.addAll(moodBookMap[mood.name]!);
    }

    // 根据时段添加
    if (timeBookMap[timeOfDay] != null) {
      pool.addAll(timeBookMap[timeOfDay]!);
    }

    // 根据季节添加
    if (seasonBookMap[season] != null) {
      pool.addAll(seasonBookMap[season]!);
    }

    // 如果池为空，使用默认列表
    if (pool.isEmpty) {
      pool.addAll(literatureBooks);
      pool.addAll(healingBooks);
    }

    return _pick(pool);
  }

  static RecommendResult recommend({Mood? mood}) {
    return RecommendResult(
      food: recommendFood(mood: mood),
      activity: recommendActivity(mood: mood),
      foodQuote: recommendFoodQuote(mood: mood),
      activityQuote: recommendActivityQuote(mood: mood),
      movie: recommendMovie(mood: mood),
      music: recommendMusic(mood: mood),
      book: recommendBook(mood: mood),
    );
  }
}

// 扩展方法，让 List 可以用 let 链式调用
extension _ListExtension<T> on List<T> {
  R let<R>(R Function(List<T>) fn) => fn(this);
}
