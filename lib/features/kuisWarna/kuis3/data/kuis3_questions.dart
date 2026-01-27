import 'package:flutter/material.dart';
import 'dart:math';
import 'package:appbutawarna/features/kuisWarna/kuis3/models/kuis3_question.dart';

class Kuis3Questions {
  static List<Kuis3Question> getAllQuestions() {
    final random = Random();

    return [
      // Soal 1-5: Gradasi Merah
      Kuis3Question(
        id: 'diff_001',
        baseColor: Color(0xFFE53935),
        differentColor: Color(0xFFEF5350),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_002',
        baseColor: Color(0xFFC62828),
        differentColor: Color(0xFFD32F2F),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_003',
        baseColor: Color(0xFFB71C1C),
        differentColor: Color(0xFFC62828),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_004',
        baseColor: Color(0xFFEF5350),
        differentColor: Color(0xFFF44336),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_005',
        baseColor: Color(0xFFD32F2F),
        differentColor: Color(0xFFE53935),
        differentPosition: random.nextInt(25),
      ),

      // Soal 6-10: Gradasi Biru
      Kuis3Question(
        id: 'diff_006',
        baseColor: Color(0xFF1976D2),
        differentColor: Color(0xFF1E88E5),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_007',
        baseColor: Color(0xFF1565C0),
        differentColor: Color(0xFF1976D2),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_008',
        baseColor: Color(0xFF0D47A1),
        differentColor: Color(0xFF1565C0),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_009',
        baseColor: Color(0xFF42A5F5),
        differentColor: Color(0xFF64B5F6),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_010',
        baseColor: Color(0xFF2196F3),
        differentColor: Color(0xFF42A5F5),
        differentPosition: random.nextInt(25),
      ),

      // Soal 11-15: Gradasi Hijau
      Kuis3Question(
        id: 'diff_011',
        baseColor: Color(0xFF43A047),
        differentColor: Color(0xFF4CAF50),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_012',
        baseColor: Color(0xFF388E3C),
        differentColor: Color(0xFF43A047),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_013',
        baseColor: Color(0xFF2E7D32),
        differentColor: Color(0xFF388E3C),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_014',
        baseColor: Color(0xFF66BB6A),
        differentColor: Color(0xFF81C784),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_015',
        baseColor: Color(0xFF4CAF50),
        differentColor: Color(0xFF66BB6A),
        differentPosition: random.nextInt(25),
      ),

      // Soal 16-20: Gradasi Kuning/Oranye
      Kuis3Question(
        id: 'diff_016',
        baseColor: Color(0xFFFFA726),
        differentColor: Color(0xFFFFB74D),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_017',
        baseColor: Color(0xFFF57C00),
        differentColor: Color(0xFFFF9800),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_018',
        baseColor: Color(0xFFFF9800),
        differentColor: Color(0xFFFFA726),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_019',
        baseColor: Color(0xFFFBC02D),
        differentColor: Color(0xFFFDD835),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_020',
        baseColor: Color(0xFFF9A825),
        differentColor: Color(0xFFFBC02D),
        differentPosition: random.nextInt(25),
      ),

      // Soal 21-25: Gradasi Ungu/Pink
      Kuis3Question(
        id: 'diff_021',
        baseColor: Color(0xFF8E24AA),
        differentColor: Color(0xFF9C27B0),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_022',
        baseColor: Color(0xFF7B1FA2),
        differentColor: Color(0xFF8E24AA),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_023',
        baseColor: Color(0xFFAB47BC),
        differentColor: Color(0xFFBA68C8),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_024',
        baseColor: Color(0xFFEC407A),
        differentColor: Color(0xFFF06292),
        differentPosition: random.nextInt(25),
      ),
      Kuis3Question(
        id: 'diff_025',
        baseColor: Color(0xFFD81B60),
        differentColor: Color(0xFFEC407A),
        differentPosition: random.nextInt(25),
      ),
    ];
  }
}