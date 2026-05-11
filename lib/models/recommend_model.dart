class RecommendResult {
  final String food;
  final String activity;
  final String foodQuote;
  final String activityQuote;
  final String? movie;
  final String? music;
  final String? book;

  const RecommendResult({
    required this.food,
    required this.activity,
    required this.foodQuote,
    required this.activityQuote,
    this.movie,
    this.music,
    this.book,
  });
}
