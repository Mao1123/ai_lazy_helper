import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/recommend_model.dart';
import '../models/mood_model.dart';
import '../models/luck_model.dart';
import '../utils/random_logic.dart';
import '../utils/time_logic.dart';
import '../widgets/result_card.dart';
import '../theme/app_theme.dart';
import '../services/share_service.dart';
import 'settings_page.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late RecommendResult _result;
  late LuckResult _luck;
  Mood? _selectedMood;
  late AnimationController _moodAnimController;
  late Animation<double> _moodScaleAnimation;

  @override
  void initState() {
    super.initState();
    _result = RandomLogic.recommend();
    _luck = LuckLogic.getTodayLuck();
    _moodAnimController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _moodScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _moodAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _moodAnimController.dispose();
    super.dispose();
  }

  void _refreshFood() {
    setState(() {
      _result = RecommendResult(
        food: RandomLogic.recommendFood(mood: _selectedMood),
        activity: _result.activity,
        foodQuote: RandomLogic.recommendFoodQuote(mood: _selectedMood),
        activityQuote: _result.activityQuote,
        movie: _result.movie,
        music: _result.music,
        book: _result.book,
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
        movie: _result.movie,
        music: _result.music,
        book: _result.book,
      );
    });
  }

  void _refreshMovie() {
    setState(() {
      _result = RecommendResult(
        food: _result.food,
        activity: _result.activity,
        foodQuote: _result.foodQuote,
        activityQuote: _result.activityQuote,
        movie: RandomLogic.recommendMovie(mood: _selectedMood),
        music: _result.music,
        book: _result.book,
      );
    });
  }

  void _refreshMusic() {
    setState(() {
      _result = RecommendResult(
        food: _result.food,
        activity: _result.activity,
        foodQuote: _result.foodQuote,
        activityQuote: _result.activityQuote,
        movie: _result.movie,
        music: RandomLogic.recommendMusic(mood: _selectedMood),
        book: _result.book,
      );
    });
  }

  void _refreshBook() {
    setState(() {
      _result = RecommendResult(
        food: _result.food,
        activity: _result.activity,
        foodQuote: _result.foodQuote,
        activityQuote: _result.activityQuote,
        movie: _result.movie,
        music: _result.music,
        book: RandomLogic.recommendBook(mood: _selectedMood),
      );
    });
  }

  void _selectMood(Mood mood) {
    _moodAnimController.forward().then((_) {
      _moodAnimController.reverse();
    });
    setState(() {
      if (_selectedMood == mood) {
        _selectedMood = null;
      } else {
        _selectedMood = mood;
      }
      _result = RandomLogic.recommend(mood: _selectedMood);
    });
  }

  Future<void> _shareResult() async {
    try {
      await ShareService.sharePoster(
        food: _result.food,
        activity: _result.activity,
        foodQuote: _result.foodQuote,
        activityQuote: _result.activityQuote,
        luckLevel: _luck.level,
        luckValue: _luck.value,
        mood: _selectedMood?.name,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('分享失败，请重试'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

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
              FontAwesomeIcons.shareNodes,
              color: Color(0xFF888888),
            ),
            onPressed: _shareResult,
          ),
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.heart,
              color: Color(0xFF888888),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
          ),
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
            const SizedBox(height: 24),
            // 标题区域
            const Center(
              child: Column(
                children: [
                  Text(
                    'AI摆烂助手',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '今天也要好好摆烂哦~',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF888888),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 日期时间信息
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFFFD6A5).withValues(alpha: 0.4),
                      const Color(0xFFFFD6A5).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD6A5).withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      _getTimeIcon(),
                      size: 16,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      TimeLogic.dateTimeDesc,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 季节和时段信息
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTag(
                    icon: _getSeasonIcon(),
                    label: TimeLogic.seasonName,
                    color: const Color(0xFF4A7C59),
                    bgColor: const Color(0xFF98D8AA),
                  ),
                  const SizedBox(width: 10),
                  _buildTag(
                    icon: FontAwesomeIcons.clock,
                    label: TimeLogic.timeOfDayName,
                    color: const Color(0xFF4A7C91),
                    bgColor: const Color(0xFFB8D4E3),
                  ),
                  if (TimeLogic.isHoliday) ...[
                    const SizedBox(width: 10),
                    _buildTag(
                      icon: FontAwesomeIcons.calendarDay,
                      label: TimeLogic.holidayName,
                      color: const Color(0xFFCC4444),
                      bgColor: const Color(0xFFFFB3B3),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 情绪选择
            _buildMoodSection(),
            const SizedBox(height: 24),
            // 今日幸运值
            _buildLuckSection(),
            const SizedBox(height: 24),
            // 今天吃什么
            ResultCard(
              icon: FontAwesomeIcons.utensils,
              title: '今天吃什么',
              result: _result.food,
              quote: _result.foodQuote,
              type: 'food',
              onRefresh: _refreshFood,
            ),
            const SizedBox(height: 12),
            // 今天干什么
            ResultCard(
              icon: FontAwesomeIcons.gamepad,
              title: '今天干什么',
              result: _result.activity,
              quote: _result.activityQuote,
              type: 'activity',
              onRefresh: _refreshActivity,
            ),
            const SizedBox(height: 12),
            // 今天看什么
            if (_result.movie != null)
              ResultCard(
                icon: FontAwesomeIcons.film,
                title: '今天看什么',
                result: _result.movie!,
                quote: '一部好电影，治愈一整天',
                type: 'movie',
                onRefresh: _refreshMovie,
              ),
            const SizedBox(height: 12),
            // 今天听什么
            if (_result.music != null)
              ResultCard(
                icon: FontAwesomeIcons.headphones,
                title: '今天听什么',
                result: _result.music!,
                quote: '音乐是灵魂的良药',
                type: 'music',
                onRefresh: _refreshMusic,
              ),
            const SizedBox(height: 12),
            // 今天读什么
            if (_result.book != null)
              ResultCard(
                icon: FontAwesomeIcons.bookOpen,
                title: '今天读什么',
                result: _result.book!,
                quote: '阅读是一座随身携带的避难所',
                type: 'book',
                onRefresh: _refreshBook,
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTag({
    required IconData icon,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: bgColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            '今天心情怎么样？',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xFF555555),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Mood.values.map((mood) {
              final isSelected = _selectedMood == mood;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () => _selectMood(mood),
                  child: ScaleTransition(
                    scale: isSelected ? _moodScaleAnimation : const AlwaysStoppedAnimation(1.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent.withValues(alpha: 0.15)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.accent
                              : Colors.grey.withValues(alpha: 0.2),
                          width: isSelected ? 2.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? AppColors.accent.withValues(alpha: 0.25)
                                : Colors.black.withValues(alpha: 0.04),
                            blurRadius: isSelected ? 12 : 6,
                            offset: Offset(0, isSelected ? 4 : 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            mood.emoji,
                            style: TextStyle(
                              fontSize: isSelected ? 28 : 24,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mood.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.accent
                                  : const Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (_selectedMood != null) ...[
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                _selectedMood!.description,
                key: ValueKey<Mood>(_selectedMood!),
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF888888),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLuckSection() {
    final luckColor = Color(LuckLogic.getColorValue(_luck.color));
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              luckColor.withValues(alpha: 0.08),
              luckColor.withValues(alpha: 0.03),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: luckColor.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: luckColor.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.clover, size: 20, color: luckColor),
                const SizedBox(width: 10),
                const Text(
                  '今日幸运值',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${_luck.value}',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: luckColor,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '/100',
                    style: TextStyle(
                      fontSize: 18,
                      color: luckColor.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    luckColor,
                    luckColor.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: luckColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                _luck.level,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _luck.advice,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _luck.value / 100,
                backgroundColor: Colors.grey.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(luckColor),
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
