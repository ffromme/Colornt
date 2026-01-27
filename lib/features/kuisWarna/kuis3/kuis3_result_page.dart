import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/providers/kuis3_provider.dart';

class Kuis3ResultPage extends StatelessWidget {
  const Kuis3ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Kuis3Provider>(context);
    final accuracy = provider.accuracy;
    final correctAnswers = provider.correctAnswers;
    final totalQuestions = provider.totalQuestions;

    // Tentukan pesan berdasarkan akurasi
    String getMessage() {
      if (accuracy >= 80) return 'Luar Biasa!';
      if (accuracy >= 60) return 'Bagus Sekali!';
      if (accuracy >= 40) return 'Cukup Baik!';
      return 'Tetap Semangat!';
    }

    String getSubMessage() {
      if (accuracy >= 80) return 'Penglihatanmu sangat tajam!';
      if (accuracy >= 60) return 'Terus berlatih untuk hasil lebih baik!';
      if (accuracy >= 40) return 'Kamu bisa lebih baik lagi!';
      return 'Jangan menyerah, coba lagi ya!';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/kuis_done.png',
                height: 200,
                width: 200,
              ),

              SizedBox(height: 24),

              // Pesan
              Text(
                getMessage(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8),

              Text(
                getSubMessage(),
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48),

              // Card skor
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Skor Kamu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$correctAnswers/$totalQuestions',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Jawaban Benar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Card akurasi
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Akurasi',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${accuracy.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: accuracy / 100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryColor,
                        ),
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48),

              // Tombol main lagi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('Kuis3Instruksi'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Main Lagi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Tombol kembali ke menu
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    side: BorderSide(color: Colors.grey[300]!, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64),
                    ),
                  ),
                  child: Text(
                    'Kembali ke Menu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}