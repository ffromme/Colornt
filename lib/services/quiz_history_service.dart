import 'package:appbutawarna/features/kuisWarna/shared/shared_prefs_helper.dart';
import 'package:appbutawarna/features/riwayat/models/quiz_history.dart';

class QuizHistoryService {
  final SharedPrefsHelper _prefs = SharedPrefsHelper();

  List<QuizHistory> getAllQuizHistory() {
    return [
      _getKuis1History(),
      _getKuis2History(),
      _getKuis3History(),
    ];
  }

  QuizHistory _getKuis1History() {
    final lastPlayed = _prefs.getKuis1LastPlayed();
    return QuizHistory(
      quizId: 'kuis1',
      quizName: 'Identifikasi Warna',
      quizImage: 'assets/images/kuis1.png',
      lastScore: _prefs.getKuis1LastScore(),
      lastAccuracy: _prefs.getKuis1LastAccuracy(),
      bestScore: _prefs.getKuis1BestScore(),
      bestAccuracy: _prefs.getKuis1BestAccuracy(),
      playCount: _prefs.getKuis1PlayCount(),
      lastPlayed: lastPlayed != null ? DateTime.parse(lastPlayed) : null,
    );
  }

  QuizHistory _getKuis2History() {
    final lastPlayed = _prefs.getKuis2LastPlayed();
    return QuizHistory(
      quizId: 'kuis2',
      quizName: 'Susun Gradasi Warna',
      quizImage: 'assets/images/kuis2.png',
      lastScore: _prefs.getKuis2LastScore(),
      lastAccuracy: _prefs.getKuis2LastAccuracy(),
      bestScore: _prefs.getKuis2BestScore(),
      bestAccuracy: _prefs.getKuis2BestAccuracy(),
      playCount: _prefs.getKuis2PlayCount(),
      lastPlayed: lastPlayed != null ? DateTime.parse(lastPlayed) : null,
    );
  }

  QuizHistory _getKuis3History() {
    final lastPlayed = _prefs.getKuis3LastPlayed();
    return QuizHistory(
      quizId: 'kuis3',
      quizName: 'Cari yang Berbeda',
      quizImage: 'assets/images/kuis3.png',
      lastScore: _prefs.getKuis3LastScore(),
      lastAccuracy: _prefs.getKuis3LastAccuracy(),
      bestScore: _prefs.getKuis3BestScore(),
      bestAccuracy: _prefs.getKuis3BestAccuracy(),
      playCount: _prefs.getKuis3PlayCount(),
      lastPlayed: lastPlayed != null ? DateTime.parse(lastPlayed) : null,
    );
  }

  // Ambil history untuk 1 kuis spesifik
  QuizHistory? getQuizHistoryById(String quizId) {
    final allHistory = getAllQuizHistory();
    try {
      return allHistory.firstWhere((quiz) => quiz.quizId == quizId);
    } catch (e) {
      return null;
    }
  }
}