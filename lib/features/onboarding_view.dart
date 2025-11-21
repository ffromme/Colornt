import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/features/auth/login_page.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _onboardIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': "Selamat Datang di\nColorn't",
      'description': "Membantumu mengenali warna di sekitar dengan mudah dan cepat.",
      'image': 'assets/images/onboard1.png',
    },
    {
      'title': "Analisis Warna\ndengan Foto",
      'description': "Dapatkan informasi warna pada foto secara akurat dengan bantuan LLM!",
      'image': 'assets/images/onboard2.png',
    },
    {
      'title': "Latih Kemampuan\nPenglihatanmu",
      'description': "Mainkan kuis warna yang seru dan cocok untuk penyandang buta warna.",
      'image': 'assets/images/onboard3.png',
    },
    {
      'title': "Aplikasi Ramah\nPengguna",
      'description': "Membantumu melihat dunia dengan penuh warna.",
      'image': 'assets/images/onboard4.png',
    },
  ];

  void onNext() {
    if (_onboardIndex < _onboardingData.length - 1) {
      setState(() {
        _onboardIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _onboardingData[_onboardIndex];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentData['title']!,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8,),

                Text(
                  currentData['description']!,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),

                const SizedBox(height: 40,),

                Image.asset(
                  currentData['image']!,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 80,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: onNext,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(60, 60),
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


