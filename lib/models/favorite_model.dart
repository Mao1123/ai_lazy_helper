class FavoriteItem {
  final String id;
  final String type; // 'food' or 'activity'
  final String content;
  final String quote;
  final DateTime createdAt;

  FavoriteItem({
    required this.id,
    required this.type,
    required this.content,
    required this.quote,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'content': content,
      'quote': quote,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      type: json['type'],
      content: json['content'],
      quote: json['quote'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
