// Kuis 1: Identifikasi Warna
import 'dart:ui';

class Kuis1Question {
  final String id;
  final Color targetColor;
  final String colorName;
  final List<String> options; // A, B, C, D
  final int correctAnswerIndex;

  Kuis1Question ({
    required this.id,
    required this.targetColor,
    required this.colorName,
    required this.options,
    required this.correctAnswerIndex,
  });
}