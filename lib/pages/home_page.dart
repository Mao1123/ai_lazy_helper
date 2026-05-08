import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/recommend_model.dart';
import '../utils/random_logic.dart';
import '../utils/time_logic.dart';
import '../widgets/result_card.dart';

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
                  SizedBox(height: 4),
                  Text(
                    '', // 时间信息在下面填充
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFAAAAAA),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // 时间提示
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
                child: Text(
                  '${TimeLogic.weekdayName} · ${TimeLogic.timeOfDayName}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF888888),
                  ),
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
