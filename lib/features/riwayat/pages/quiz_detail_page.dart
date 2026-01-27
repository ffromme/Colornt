import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/riwayat/models/quiz_history.dart';

class QuizDetailPage extends StatelessWidget {
  final QuizHistory quiz;

  const QuizDetailPage({
    super.key,
    required this.quiz,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return 'Belum pernah dimainkan';
    return DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Detail Riwayat Kuis',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan gambar dan nama kuis
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.textSecondary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        quiz.quizImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      quiz.quizName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Statistik Permainan Terakhir
              _buildSectionTitle('Permainan Terakhir'),
              SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.textSecondary.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                        SizedBox(width: 8),
                        Text(
                          _formatDate(quiz.lastPlayed),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            label: 'Skor',
                            value: '${quiz.lastScore}',
                            color: AppTheme.primaryColor,
                            icon: Icons.stars,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            label: 'Akurasi',
                            value: '${quiz.lastAccuracy.toStringAsFixed(0)}%',
                            color: AppTheme.primaryColor,
                            icon: Icons.check_circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Rekor Terbaik
              _buildSectionTitle('Rekor Terbaik'),
              SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        label: 'Skor Tertinggi',
                        value: '${quiz.bestScore}',
                        color: AppTheme.primaryColor,
                        icon: Icons.emoji_events,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        label: 'Akurasi Tertinggi',
                        value: '${quiz.bestAccuracy.toStringAsFixed(0)}%',
                        color: AppTheme.primaryColor,
                        icon: Icons.trending_up,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Total Permainan
              _buildSectionTitle('Statistik'),
              SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.textSecondary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 24,
                      color: AppTheme.primaryColor,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Dimainkan ${quiz.playCount} kali',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: color,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}