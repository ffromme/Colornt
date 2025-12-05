import 'dart:math';
import 'package:flutter/material.dart';
import 'package:appbutawarna/features/kuisWarna/kuis1/models/kuis1_question.dart';
import 'package:appbutawarna/features/kuisWarna/kuis1/data/kuis1_questions.dart';
import 'package:appbutawarna/features/kuisWarna/shared/shared_prefs_helper.dart';

class Kuis1Provider extends ChangeNotifier {
  final _prefs = SharedPrefsHelper();

  final List<Kuis1Question> _allQuestions = Kuis1Questions.getAllQuestions();
  List<Kuis1Question> _currentQuestions = [];

  int _currentIndex = 0;
  int _correctAnswers = 0;
  int? _selectedAnswer;
  bool _isAnswered = false;

  List<Kuis1Question> get currentQuestions => _currentQuestions;
  int get currentIndex => _currentIndex;
  int get correctAnswer => _correctAnswers;
  int? get selectedAnswer => _selectedAnswer;
  bool get isAnswered => _isAnswered;
  int get totalQuestions => _currentQuestions.length;
  bool get isQuizComplete => _currentIndex >= _currentQuestions.length;
  double get accuracy => totalQuestions > 0 ? (_correctAnswers / totalQuestions) * 100 : 0.0;

  Kuis1Question? get currentQuestion {
    if (_currentIndex < _currentQuestions.length) {
      return _currentQuestions[_currentIndex];
    }
    return null;
  }

  void loadRandomQuestions() {
    final random = Random();
    final shuffled = List<Kuis1Question>.from(_allQuestions);
    shuffled.shuffle(random);

    _currentQuestions = shuffled.take(5).toList();
    _currentIndex = 0;
    _correctAnswers = 0;
    _selectedAnswer = null;
    _isAnswered = false;

    notifyListeners();
  }

  void selectAnswer(int answerIndex) {
    if (_isAnswered) return;

    _selectedAnswer = answerIndex;
    _isAnswered = true;

    if (currentQuestion != null && answerIndex == currentQuestion!.correctAnswerIndex) {
      _correctAnswers++;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (!_isAnswered) return;

    _currentIndex++;
    _selectedAnswer = null;
    _isAnswered = false;

    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _correctAnswers = 0;
    _selectedAnswer = null;
    _isAnswered = false;

    notifyListeners();
  }

  void startNewQuiz() {
    loadRandomQuestions();
  }

  Future<void> saveQuizResult() async {
    await _prefs.saveKuis1LastScore(_correctAnswers);
    await _prefs.saveKuis1LastAccuracy(accuracy);

    final bestScore = _prefs.getKuis1BestScore();
    if (_correctAnswers > bestScore) {
      await _prefs.saveKuis1BestScore(_correctAnswers);
      await _prefs.saveKuis1BestAccuracy(accuracy);
    }
    await _prefs.incrementKuis1PlayCount();
    await _prefs.saveKuis1LastPlayed(DateTime.now().toIso8601String());
  }

  Map<String, dynamic> getQuizHistory() {
    return _prefs.getKuis1History();
  }
}