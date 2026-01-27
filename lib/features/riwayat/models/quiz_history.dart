class QuizHistory {
  final String quizId;
  final String quizName;
  final String quizImage;
  final int lastScore;
  final double lastAccuracy;
  final int bestScore;
  final double bestAccuracy;
  final int playCount;
  final DateTime? lastPlayed;

  QuizHistory({
    required this.quizId,
    required this.quizName,
    required this.quizImage,
    required this.lastScore,
    required this.lastAccuracy,
    required this.bestScore,
    required this.bestAccuracy,
    required this.playCount,
    this.lastPlayed,
  });

  bool get hasBeenPlayed => playCount > 0;
}