import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/recommend_model.dart';
import '../models/mood_model.dart';
import '../models/luck_model.dart';
import '../utils/random_logic.dart';
import '../utils/time_logic.dart';
import '../widgets/result_card.dart';
import '../theme/app_theme.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RecommendResult _result;
  late LuckResult _luck;
  Mood? _selectedMood;

  @override
  void initState() {
    super.initState();
    _result = RandomLogic.recommend();
    _luck = LuckLogic.getTodayLuck();
  }

  void _refreshFood() {
    setState(() {
      _result = RecommendResult(
        food: RandomLogic.recommendFood(mood: _selectedMood),
        activity: _result.activity,
        foodQuote: RandomLogic.recommendFoodQuote(mood: _selectedMood),
        activityQuote: _result.activityQuote,
      );
    });
  }

  void _refreshActivity() {
    setState(() {
      _result = RecommendResult(
        food: _result.food,
        activity: RandomLogic.recommendActivity(mood: _selectedMood),
        foodQuote: _result.foodQuote,
        activityQuote: RandomLogic.recommendActivityQuote(mood: _selectedMood),
      );
    });
  }

  void _selectMood(Mood mood) {
    setState(() {
      if (_selectedMood == mood) {
        // 取消选择
        _selectedMood = null;
      } else {
        _selectedMood = mood;
      }
      // 重新推荐
      _result = RandomLogic.recommend(mood: _selectedMood);
    });
  }

  // 获取时间图标
  IconData _getTimeIcon() {
    switch (TimeLogic.timeOfDay) {
      case AppTimeOfDay.morning:
        return FontAwesomeIcons.sun;
      case AppTimeOfDay.lunch:
        return FontAwesomeIcons.cloudSun;
      case AppTimeOfDay.afternoon:
        return FontAwesomeIcons.cloud;
      case AppTimeOfDay.dinner:
        return FontAwesomeIcons.moon;
      case AppTimeOfDay.lateNight:
        return FontAwesomeIcons.star;
    }
  }

  // 获取季节图标
  IconData _getSeasonIcon() {
    switch (TimeLogic.season) {
      case Season.spring:
        return FontAwesomeIcons.seedling;
      case Season.summer:
        return FontAwesomeIcons.sun;
      case Season.autumn:
        return FontAwesomeIcons.leaf;
      case Season.winter:
        return FontAwesomeIcons.snowflake;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.gear,
              color: Color(0xFF888888),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 30),
            // 标题区域
            const Center(
              child: Column(
                children: [
                  Text(
                    'AI摆烂助手',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '今天也要好好摆烂哦~',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // 日期时间信息
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD6A5).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      _getTimeIcon(),
                      size: 14,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      TimeLogic.dateTimeDesc,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // 季节和时段信息
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF98D8AA).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          _getSeasonIcon(),
                          size: 12,
                          color: const Color(0xFF4A7C59),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          TimeLogic.seasonName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4A7C59),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB8D4E3).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      TimeLogic.timeOfDayName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF4A7C91),
                      ),
                    ),
                  ),
                  if (TimeLogic.isHoliday) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB3B3).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        TimeLogic.holidayName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFCC4444),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 情绪选择
            Center(
              child: Column(
                children: [
                  const Text(
                    '今天心情怎么样？',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Mood.values.map((mood) {
                      final isSelected = _selectedMood == mood;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () => _selectMood(mood),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accent.withValues(alpha: 0.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.accent
                                    : Colors.grey.withValues(alpha: 0.3),
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.accent.withValues(alpha: 0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  mood.emoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  mood.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? AppColors.accent
                                        : const Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (_selectedMood != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _selectedMood!.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888888),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 今日幸运值
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(LuckLogic.getColorValue(_luck.color)).withValues(alpha: 0.1),
                      Color(LuckLogic.getColorValue(_luck.color)).withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(LuckLogic.getColorValue(_luck.color)).withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.clover,
                          size: 18,
                          color: Color(0xFF4A7C59),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '今日幸运值',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${_luck.value}',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(LuckLogic.getColorValue(_luck.color)),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            '/100',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(LuckLogic.getColorValue(_luck.color)).withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(LuckLogic.getColorValue(_luck.color)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _luck.level,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _luck.advice,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // 幸运进度条
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _luck.value / 100,
                        backgroundColor: Colors.grey.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(LuckLogic.getColorValue(_luck.color)),
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 今天吃什么
            ResultCard(
              icon: FontAwesomeIcons.utensils,
              title: '今天吃什么',
              result: _result.food,
              quote: _result.foodQuote,
              onRefresh: _refreshFood,
            ),
            const SizedBox(height: 10),
            // 今天干什么
            ResultCard(
              icon: FontAwesomeIcons.gamepad,
              title: '今天干什么',
              result: _result.activity,
              quote: _result.activityQuote,
              onRefresh: _refreshActivity,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
