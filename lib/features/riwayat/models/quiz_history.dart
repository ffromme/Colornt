import 'package:cloud_firestore/cloud_firestore.dart';

class QuizHistory {
  final String quizId;
  final String userId;
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
    required this.userId,
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

  // Convert dari Firestore
  factory QuizHistory.fromFirestore(DocumentSnapshot doc, String quizName, String quizImage) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      return QuizHistory(
        quizId: doc.id,
        userId: '',
        quizName: quizName,
        quizImage: quizImage,
        lastScore: 0,
        lastAccuracy: 0.0,
        bestScore: 0,
        bestAccuracy: 0.0,
        playCount: 0,
        lastPlayed: null,
      );
    }

    return QuizHistory(
      quizId: doc.id,
      userId: data['userId'] ?? '',
      quizName: quizName,
      quizImage: quizImage,
      lastScore: data['lastScore'] ?? 0,
      lastAccuracy: (data['lastAccuracy'] ?? 0.0).toDouble(),
      bestScore: data['bestScore'] ?? 0,
      bestAccuracy: (data['bestAccuracy'] ?? 0.0).toDouble(),
      playCount: data['playCount'] ?? 0,
      lastPlayed: data['lastPlayed'] != null
          ? (data['lastPlayed'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert ke Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'lastScore': lastScore,
      'lastAccuracy': lastAccuracy,
      'bestScore': bestScore,
      'bestAccuracy': bestAccuracy,
      'playCount': playCount,
      'lastPlayed': lastPlayed != null ? Timestamp.fromDate(lastPlayed!) : null,
    };
  }
}