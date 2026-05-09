import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/app_theme.dart';

class ShareService {
  static final ScreenshotController _screenshotController = ScreenshotController();

  // 生成分享海报 Widget
  static Widget buildSharePoster({
    required String food,
    required String activity,
    required String foodQuote,
    required String activityQuote,
    required String luckLevel,
    required int luckValue,
    String? mood,
  }) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF6EA),
            Color(0xFFFFD6A5),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          const Text(
            'AI摆烂助手',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '今天也要好好摆烂哦~',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 20),
          // 日期
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${DateTime.now().month}月${DateTime.now().day}日',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ),
          if (mood != null) ...[
            const SizedBox(height: 12),
            Text(
              '今日心情：$mood',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
          const SizedBox(height: 20),
          // 推荐内容
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildRecommendationItem(
                  icon: '🍜',
                  title: '今天吃什么',
                  content: food,
                  quote: foodQuote,
                ),
                const SizedBox(height: 16),
                _buildRecommendationItem(
                  icon: '🎮',
                  title: '今天干什么',
                  content: activity,
                  quote: activityQuote,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 幸运值
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🍀', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  '今日幸运值：$luckValue/100 ($luckLevel)',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // 底部
          const Text(
            '— AI摆烂助手 —',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildRecommendationItem({
    required String icon,
    required String title,
    required String content,
    required String quote,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '"$quote"',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF888888),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // 截图并分享
  static Future<void> sharePoster({
    required String food,
    required String activity,
    required String foodQuote,
    required String activityQuote,
    required String luckLevel,
    required int luckValue,
    String? mood,
  }) async {
    final widget = buildSharePoster(
      food: food,
      activity: activity,
      foodQuote: foodQuote,
      activityQuote: activityQuote,
      luckLevel: luckLevel,
      luckValue: luckValue,
      mood: mood,
    );

    final imageBytes = await _screenshotController.captureFromWidget(
      widget,
      pixelRatio: 2.0,
    );

    // 保存到临时文件
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/ai_lazy_helper_share.png');
    await file.writeAsBytes(imageBytes);

    // 分享
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'AI摆烂助手推荐：今天吃$food，$activity！',
    );
  }

  // 保存到相册
  static Future<Uint8List> generatePosterBytes({
    required String food,
    required String activity,
    required String foodQuote,
    required String activityQuote,
    required String luckLevel,
    required int luckValue,
    String? mood,
  }) async {
    final widget = buildSharePoster(
      food: food,
      activity: activity,
      foodQuote: foodQuote,
      activityQuote: activityQuote,
      luckLevel: luckLevel,
      luckValue: luckValue,
      mood: mood,
    );

    return await _screenshotController.captureFromWidget(
      widget,
      pixelRatio: 2.0,
    );
  }
}
