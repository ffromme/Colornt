import 'dart:math';
import 'package:flutter/material.dart';
import 'package:appbutawarna/features/kuisWarna/kuis2/models/kuis2_question.dart';
import 'package:appbutawarna/features/kuisWarna/kuis2/data/kuis2_questions.dart';
import 'package:appbutawarna/services/quiz_history_service.dart';

class Kuis2Provider extends ChangeNotifier {
  final _quizHistoryService = QuizHistoryService();

  final List<Kuis2Question> _allQuestions = Kuis2Questions.getAllQuestions();
  Kuis2Question? _currentQuestion;

  Map<int, Color> _filledSlots = {};
  List<Color> _availableColors = [];
  bool _isCompleted = false;

  // Getters
  Kuis2Question? get currentQuestion => _currentQuestion;
  Map<int, Color> get filledSlots => _filledSlots;
  List<Color> get availableColors => _availableColors;
  bool get isCompleted => _isCompleted;

  // Total slot yang harus diisi (6 slot tengah, index 1-6)
  int get totalSlotsToFill => 6;
  int get filledCount => _filledSlots.length;

  // Check apakah semua slot sudah diisi
  bool get allSlotsFilled => _filledSlots.length >= totalSlotsToFill;

  // Load 1 soal acak dari 10 soal
  void loadRandomQuestion() {
    final random = Random();
    _currentQuestion = _allQuestions[random.nextInt(_allQuestions.length)];

    // Reset state
    _filledSlots.clear();
    _availableColors = List<Color>.from(_currentQuestion!.shuffledColors);
    _isCompleted = false;

    notifyListeners();
  }

  // Check apakah warna masih available
  bool isColorAvailable(Color color) {
    return _availableColors.contains(color);
  }

  // Isi slot dengan warna
  void fillSlot(int slotIndex, Color color) {
    if (_isCompleted) return;

    // Jika slot sudah terisi, kembalikan warna lama ke available
    if (_filledSlots.containsKey(slotIndex)) {
      final oldColor = _filledSlots[slotIndex]!;
      _availableColors.add(oldColor);
    }

    // Isi slot dengan warna baru
    _filledSlots[slotIndex] = color;
    _availableColors.remove(color);

    notifyListeners();
  }

  // Remove warna dari slot (return to available)
  void removeFromSlot(int slotIndex) {
    if (_isCompleted || !_filledSlots.containsKey(slotIndex)) return;

    final color = _filledSlots[slotIndex]!;
    _filledSlots.remove(slotIndex);
    _availableColors.add(color);

    notifyListeners();
  }

  // Get warna untuk slot tertentu
  Color? getSlotColor(int index) {
    if (_currentQuestion == null) return null;

    // Slot pertama (index 0) = startColor
    if (index == 0) return _currentQuestion!.startColor;

    // Slot terakhir (index 7) = endColor
    if (index == 7) return _currentQuestion!.endColor;

    // Slot tengah (index 1-6) = dari filledSlots atau null
    return _filledSlots[index];
  }

  // Hitung skor berdasarkan posisi yang benar
  int calculateScore() {
    if (_currentQuestion == null) return 0;

    int correctPositions = 0;

    // Check setiap slot tengah (index 1-6)
    for (int i = 1; i <= 6; i++) {
      if (_filledSlots.containsKey(i)) {
        if (_filledSlots[i] == _currentQuestion!.correctGradient[i - 1]) {
          correctPositions++;
        }
      }
    }

    return correctPositions;
  }

  // Hitung akurasi
  double get accuracy {
    final score = calculateScore();
    return (score / totalSlotsToFill) * 100;
  }

  // Submit jawaban
  void submitAnswer() {
    if (!allSlotsFilled) return;

    _isCompleted = true;
    notifyListeners();
  }

  // Reset kuis
  void resetQuiz() {
    _filledSlots.clear();
    if (_currentQuestion != null) {
      _availableColors = List<Color>.from(_currentQuestion!.shuffledColors);
    }
    _isCompleted = false;
    notifyListeners();
  }

  // Simpan hasil kuis
  Future<void> saveQuizResult() async {
    final score = calculateScore();
    final acc = accuracy;

    try {
      await _quizHistoryService.saveQuizResult(
        quizId: 'kuis2',
        score: score,
        accuracy: acc,
      );
    } catch (e) {
      print('Error saving quiz result: $e');
    }
  }

  // Get score dan accuracy untuk result page
  int get score => calculateScore();
}