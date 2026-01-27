import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/providers/kuis3_provider.dart';
import 'kuis3_result_page.dart';

class Kuis3Page extends StatefulWidget {
  const Kuis3Page({super.key});

  @override
  State<Kuis3Page> createState() => _Kuis3PageState();
}

class _Kuis3PageState extends State<Kuis3Page> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<Kuis3Provider>();
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
          'Cari yang Berbeda',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<Kuis3Provider>(
        builder: (context, provider, child) {
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
                  builder: (context) => Kuis3ResultPage(),
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
                  // Progress
                  Text(
                    'Soal ${provider.currentIndex + 1}/${provider.totalQuestions}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32),

                  // Grid 5x5
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: 25,
                          itemBuilder: (context, index) {
                            return _buildColorBox(provider, index);
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

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

  Widget _buildColorBox(Kuis3Provider provider, int index) {
    final color = provider.getBoxColor(index);
    final borderColor = provider.getBoxBorderColor(index);
    final isSelected = provider.selectedBox == index;

    return GestureDetector(
      onTap: provider.isAnswered
          ? null
          : () => provider.selectBox(index),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: borderColor != null
              ? Border.all(color: AppTheme.primaryColor, width: 3)
              : isSelected
              ? Border.all(color: AppTheme.primaryColor, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}