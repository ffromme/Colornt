import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appbutawarna/features/kuisWarna/kuis1/providers/kuis1_provider.dart';
import 'kuis1_result_page.dart';

class Kuis1Page extends StatefulWidget {
  const Kuis1Page({super.key});

  @override
  State<Kuis1Page> createState() => _Kuis1PageState();
}

class _Kuis1PageState extends State<Kuis1Page> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Load soal saat widget pertama kali dibuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<Kuis1Provider>();
      if (!_isInitialized) {
        provider.loadRandomQuestions();
        setState(() {
          _isInitialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Identifikasi Warna',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<Kuis1Provider>(
        builder: (context, provider, child) {
          // Tampilkan loading jika belum initialized
          if (!_isInitialized || provider.currentQuestions.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          // Jika kuis selesai, navigate ke hasil
          if (provider.isQuizComplete) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.saveQuizResult();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Kuis1ResultPage(),
                ),
              );
            });
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          final question = provider.currentQuestion;
          if (question == null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40),

                  // Kotak warna
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: question.targetColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Pertanyaan
                  Text(
                    'Warna apakah kotak di atas?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32),

                  // Opsi jawaban
                  ...List.generate(4, (index) {
                    final optionLabel = String.fromCharCode(65 + index); // A, B, C, D
                    final isSelected = provider.selectedAnswer == index;
                    final isCorrect = index == question.correctAnswerIndex;
                    final showResult = provider.isAnswered;

                    Color? backgroundColor;
                    Color borderColor = Color(0xFFE0E0E0);
                    Color textColor = Colors.black87;

                    if (showResult) {
                      if (isCorrect) {
                        backgroundColor = AppTheme.primaryColor;
                        borderColor = AppTheme.primaryColor;
                        textColor = Colors.white;
                      } else if (isSelected && !isCorrect) {
                        backgroundColor = Color(0xFFE74C3C);
                        borderColor = Color(0xFFE74C3C);
                        textColor = Colors.white;
                      }
                    } else if (isSelected) {
                      borderColor = AppTheme.primaryColor;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: InkWell(
                        onTap: provider.isAnswered
                            ? null
                            : () => provider.selectAnswer(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: backgroundColor ?? Colors.white,
                            borderRadius: BorderRadius.circular(64),
                            border: Border.all(
                              color: borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            '$optionLabel. ${question.options[index]}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  Spacer(),

                  // Tombol lanjut
                  if (provider.isAnswered)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => provider.nextQuestion(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(64),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.currentIndex < provider.totalQuestions - 1
                                  ? 'Selanjutnya'
                                  : 'Lihat Hasil',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}