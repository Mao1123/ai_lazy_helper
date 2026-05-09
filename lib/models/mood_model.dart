enum Mood {
  happy,    // 开心
  emo,      // emo
  lazy,     // 摆烂
  crazy,    // 发疯
}

extension MoodExtension on Mood {
  String get name {
    switch (this) {
      case Mood.happy:
        return '开心';
      case Mood.emo:
        return 'emo';
      case Mood.lazy:
        return '摆烂';
      case Mood.crazy:
        return '发疯';
    }
  }

  String get emoji {
    switch (this) {
      case Mood.happy:
        return '😊';
      case Mood.emo:
        return '😢';
      case Mood.lazy:
        return '😴';
      case Mood.crazy:
        return '🤪';
    }
  }

  String get description {
    switch (this) {
      case Mood.happy:
        return '今天心情不错';
      case Mood.emo:
        return '有点小情绪';
      case Mood.lazy:
        return '什么都不想干';
      case Mood.crazy:
        return '嗨到不行';
    }
  }
}
