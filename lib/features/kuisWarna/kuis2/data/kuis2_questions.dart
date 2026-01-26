import 'package:flutter/material.dart';
import '../models/kuis2_question.dart';

class Kuis2Questions {
  static List<Kuis2Question> getAllQuestions() {
    return [
      // Soal 1: Oranye ke Kuning
      Kuis2Question(
        id: 'grad_001',
        startColor: Color(0xFFFF8C00), // Dark Orange
        endColor: Color(0xFFFFFF99),   // Light Yellow
        correctGradient: [
          Color(0xFFFF9F1C),
          Color(0xFFFFB347),
          Color(0xFFFFC966),
          Color(0xFFFFDB7F),
          Color(0xFFFFE999),
          Color(0xFFFFF2B3),
        ],
      ),

      // Soal 2: Hijau Tua ke Hijau Muda
      Kuis2Question(
        id: 'grad_002',
        startColor: Color(0xFF1B5E20), // Dark Green
        endColor: Color(0xFFC8E6C9),   // Light Green
        correctGradient: [
          Color(0xFF2E7D32),
          Color(0xFF43A047),
          Color(0xFF66BB6A),
          Color(0xFF81C784),
          Color(0xFF9CCC65),
          Color(0xFFAED581),
        ],
      ),

      // Soal 3: Biru Tua ke Biru Muda
      Kuis2Question(
        id: 'grad_003',
        startColor: Color(0xFF0D47A1), // Dark Blue
        endColor: Color(0xFFBBDEFB),   // Light Blue
        correctGradient: [
          Color(0xFF1565C0),
          Color(0xFF1976D2),
          Color(0xFF1E88E5),
          Color(0xFF42A5F5),
          Color(0xFF64B5F6),
          Color(0xFF90CAF9),
        ],
      ),

      // Soal 4: Merah ke Pink
      Kuis2Question(
        id: 'grad_004',
        startColor: Color(0xFFB71C1C), // Dark Red
        endColor: Color(0xFFF8BBD0),   // Light Pink
        correctGradient: [
          Color(0xFFC62828),
          Color(0xFFD32F2F),
          Color(0xFFE53935),
          Color(0xFFEF5350),
          Color(0xFFF06292),
          Color(0xFFF48FB1),
        ],
      ),

      // Soal 5: Ungu Tua ke Ungu Muda
      Kuis2Question(
        id: 'grad_005',
        startColor: Color(0xFF4A148C), // Dark Purple
        endColor: Color(0xFFE1BEE7),   // Light Purple
        correctGradient: [
          Color(0xFF6A1B9A),
          Color(0xFF7B1FA2),
          Color(0xFF8E24AA),
          Color(0xFF9C27B0),
          Color(0xFFAB47BC),
          Color(0xFFBA68C8),
        ],
      ),

      // Soal 6: Coklat ke Krem
      Kuis2Question(
        id: 'grad_006',
        startColor: Color(0xFF3E2723), // Dark Brown
        endColor: Color(0xFFD7CCC8),   // Light Brown/Cream
        correctGradient: [
          Color(0xFF4E342E),
          Color(0xFF5D4037),
          Color(0xFF6D4C41),
          Color(0xFF795548),
          Color(0xFF8D6E63),
          Color(0xFFA1887F),
        ],
      ),

      // Soal 7: Cyan Tua ke Cyan Muda
      Kuis2Question(
        id: 'grad_007',
        startColor: Color(0xFF006064), // Dark Cyan
        endColor: Color(0xFFB2EBF2),   // Light Cyan
        correctGradient: [
          Color(0xFF00838F),
          Color(0xFF0097A7),
          Color(0xFF00ACC1),
          Color(0xFF00BCD4),
          Color(0xFF26C6DA),
          Color(0xFF4DD0E1),
        ],
      ),

      // Soal 8: Magenta ke Pink Muda
      Kuis2Question(
        id: 'grad_008',
        startColor: Color(0xFF880E4F), // Dark Magenta
        endColor: Color(0xFFF48FB1),   // Light Pink
        correctGradient: [
          Color(0xFFA81555),
          Color(0xFFC2185B),
          Color(0xFFD81B60),
          Color(0xFFEC407A),
          Color(0xFFF06292),
          Color(0xFFF48FB1),
        ],
      ),

      // Soal 9: Kuning Tua ke Kuning Muda
      Kuis2Question(
        id: 'grad_009',
        startColor: Color(0xFFF57F17), // Dark Yellow
        endColor: Color(0xFFFFF9C4),   // Light Yellow
        correctGradient: [
          Color(0xFFF9A825),
          Color(0xFFFBC02D),
          Color(0xFFFDD835),
          Color(0xFFFFEB3B),
          Color(0xFFFFEE58),
          Color(0xFFFFF176),
        ],
      ),

      // Soal 10: Indigo ke Lavender
      Kuis2Question(
        id: 'grad_010',
        startColor: Color(0xFF1A237E), // Dark Indigo
        endColor: Color(0xFFC5CAE9),   // Light Indigo/Lavender
        correctGradient: [
          Color(0xFF283593),
          Color(0xFF303F9F),
          Color(0xFF3949AB),
          Color(0xFF3F51B5),
          Color(0xFF5C6BC0),
          Color(0xFF7986CB),
        ],
      ),
    ];
  }
}