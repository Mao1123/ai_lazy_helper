import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/recommend_model.dart';
import '../utils/random_logic.dart';
import '../utils/time_logic.dart';
import '../widgets/result_card.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RecommendResult _result;

  @override
  void initState() {
    super.initState();
    _result = RandomLogic.recommend();
  }

  void _refreshFood() {
    setState(() {
      _result = RecommendResult(
        food: RandomLogic.recommendFood(),
        activity: _result.activity,
        foodQuote: RandomLogic.recommendFoodQuote(),
        activityQuote: _result.activityQuote,
      );
    });
  }

  void _refreshActivity() {
    setState(() {
      _result = RecommendResult(
        food: _result.food,
        activity: RandomLogic.recommendActivity(),
        foodQuote: _result.foodQuote,
        activityQuote: RandomLogic.recommendActivityQuote(),
      );
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
