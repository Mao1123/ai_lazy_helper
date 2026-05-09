import 'dart:math';

class LuckResult {
  final int value;        // 幸运值 0-100
  final String level;     // 幸运等级
  final String color;     // 对应颜色
  final String advice;    // 幸运建议

  const LuckResult({
    required this.value,
    required this.level,
    required this.color,
    required this.advice,
  });
}

class LuckLogic {
  // 根据日期生成固定的幸运值（同一天结果相同）
  static int _generateDailySeed() {
    final now = DateTime.now();
    // 使用日期作为种子，确保同一天结果相同
    return now.year * 10000 + now.month * 100 + now.day;
  }

  // 获取今日幸运值
  static LuckResult getTodayLuck() {
    final seed = _generateDailySeed();
    final random = Random(seed);
    final value = random.nextInt(101); // 0-100

    String level;
    String color;
    String advice;

    if (value >= 90) {
      level = '大吉';
      color = '#FF4444';
      advice = '今天运势爆棚！适合做重要决定，大胆尝试新事物！';
    } else if (value >= 75) {
      level = '中吉';
      color = '#FF8C42';
      advice = '运势不错，适合社交和外出，会有好事发生！';
    } else if (value >= 60) {
      level = '小吉';
      color = '#FFD6A5';
      advice = '运势平稳，适合按部就班，保持好心情。';
    } else if (value >= 40) {
      level = '平';
      color = '#98D8AA';
      advice = '运势一般，不宜做重大决定，适合休息调整。';
    } else if (value >= 20) {
      level = '小凶';
      color = '#B8D4E3';
      advice = '运势欠佳，注意言行，避免与人争执。';
    } else {
      level = '大凶';
      color = '#888888';
      advice = '今天宜静不宜动，建议在家休息，早点睡觉。';
    }

    return LuckResult(
      value: value,
      level: level,
      color: color,
      advice: advice,
    );
  }

  // 获取幸运颜色（用于UI）
  static int getColorValue(String hexColor) {
    return int.parse(hexColor.replaceFirst('#', '0xFF'));
  }
}
