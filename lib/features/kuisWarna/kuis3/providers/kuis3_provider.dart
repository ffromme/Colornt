import 'dart:math';
import 'package:flutter/material.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/models/kuis3_question.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/data/kuis3_questions.dart';
import 'package:appbutawarna/features/kuisWarna/shared/shared_prefs_helper.dart';

class Kuis3Provider extends ChangeNotifier {
  // Helper
  final _prefs = SharedPrefsHelper();

  // Data soal
  final List<Kuis3Question> _allQuestions = Kuis3Questions.getAllQuestions();
  List<Kuis3Question> _currentQuestions = [];

  // State kuis
  int _currentIndex = 0;
  int _correctAnswers = 0;
  int? _selectedBox;
  bool _isAnswered = false;

  // Getters
  List<Kuis3Question> get currentQuestions => _currentQuestions;
  int get currentIndex => _currentIndex;
  int get correctAnswers => _correctAnswers;
  int? get selectedBox => _selectedBox;
  bool get isAnswered => _isAnswered;
  int get totalQuestions => _currentQuestions.length;
  bool get isQuizComplete => _currentIndex >= _currentQuestions.length;
  double get accuracy => totalQuestions > 0
      ? (_correctAnswers / totalQuestions) * 100
      : 0.0;

  Kuis3Question? get currentQuestion {
    if (_currentIndex < _currentQuestions.length) {
      return _currentQuestions[_currentIndex];
    }
    return null;
  }

  // Load 5 soal acak dari 25 soal yang tersedia
  void loadRandomQuestions() {
    final random = Random();
    final shuffled = List<Kuis3Question>.from(_allQuestions);
    shuffled.shuffle(random);

    _currentQuestions = shuffled.take(5).toList();
    _currentIndex = 0;
    _correctAnswers = 0;
    _selectedBox = null;
    _isAnswered = false;

    notifyListeners();
  }

  // Pilih kotak
  void selectBox(int boxIndex) {
    if (_isAnswered) return; // Tidak bisa ubah jawaban setelah dijawab

    _selectedBox = boxIndex;
    _isAnswered = true;

    // Cek apakah kotak yang dipilih benar
    if (currentQuestion != null &&
        boxIndex == currentQuestion!.differentPosition) {
      _correctAnswers++;
    }

    notifyListeners();
  }

  // Lanjut ke soal berikutnya
  void nextQuestion() {
    if (!_isAnswered) return; // Harus jawab dulu

    _currentIndex++;
    _selectedBox = null;
    _isAnswered = false;

    notifyListeners();
  }

  // Reset kuis
  void resetQuiz() {
    _currentIndex = 0;
    _correctAnswers = 0;
    _selectedBox = null;
    _isAnswered = false;

    notifyListeners();
  }

  // Mulai kuis baru (acak soal lagi)
  void startNewQuiz() {
    loadRandomQuestions();
  }

  // Simpan hasil kuis menggunakan helper
  Future<void> saveQuizResult() async {
    // Simpan skor terakhir
    await _prefs.saveKuis3LastScore(_correctAnswers);
    await _prefs.saveKuis3LastAccuracy(accuracy);

    // Update best score jika lebih tinggi
    final bestScore = _prefs.getKuis3BestScore();
    if (_correctAnswers > bestScore) {
      await _prefs.saveKuis3BestScore(_correctAnswers);
      await _prefs.saveKuis3BestAccuracy(accuracy);
    }
    await _prefs.incrementKuis3PlayCount();
    await _prefs.saveKuis3LastPlayed(DateTime.now().toIso8601String());
  }

  // Check apakah kotak adalah jawaban yang benar
  bool isCorrectBox(int boxIndex) {
    return currentQuestion?.differentPosition == boxIndex;
  }

  // Get color untuk box tertentu
  Color getBoxColor(int boxIndex) {
    if (currentQuestion == null) return Colors.grey;

    if (boxIndex == currentQuestion!.differentPosition) {
      return currentQuestion!.differentColor;
    } else {
      return currentQuestion!.baseColor;
    }
  }

  // Get border color untuk feedback visual
  Color? getBoxBorderColor(int boxIndex) {
    if (!_isAnswered || _selectedBox == null) return null;

    final isCorrect = boxIndex == currentQuestion?.differentPosition;
    final isSelected = boxIndex == _selectedBox;

    if (isCorrect) {
      return Color(0xFF4CAF50); // Hijau untuk jawaban benar
    } else if (isSelected && !isCorrect) {
      return Color(0xFFE74C3C); // Merah untuk jawaban salah
    }

    return null;
  }
}