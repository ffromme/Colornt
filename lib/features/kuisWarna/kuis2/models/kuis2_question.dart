import 'package:flutter/material.dart';

class Kuis2Question {
  final String id;
  final Color startColor;
  final Color endColor;
  final List<Color> correctGradient; // Gradasi yang benar (6 warna tengah)
  final List<Color> shuffledColors; // Warna yang akan ditampilkan (diacak)

  Kuis2Question({
    required this.id,
    required this.startColor,
    required this.endColor,
    required this.correctGradient,
  }) : shuffledColors = List<Color>.from(correctGradient)..shuffle();

  // Total slot = 8 (start + 6 tengah + end)
  int get totalSlots => 8;
  int get middleSlots => 6;
}