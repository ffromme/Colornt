import 'package:flutter/material.dart';

class Kuis3Question {
  final String id;
  final Color baseColor;
  final Color differentColor;
  final int differentPosition; // 0-24 (grid 5x5)

  Kuis3Question({
    required this.id,
    required this.baseColor,
    required this.differentColor,
    required this.differentPosition,
  });

  // Total kotak dalam grid
  int get totalBoxes => 25;
}