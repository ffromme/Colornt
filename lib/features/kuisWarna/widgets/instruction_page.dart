import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class instruction_page extends StatelessWidget {
  final String image;
  final String instruksi;
  final VoidCallback onPressed;

  const instruction_page({
    super.key,
    required this.image,
    required this.instruksi,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 260,
            width: 260,
            child: Image.asset(
              image,
            ),
          ),
          const SizedBox(height: 64,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Instruksi:",
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24,),
                Text(
                  instruksi,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          PrimaryButton(text: "Mulai Kuis", onPressed: onPressed),

          const SizedBox(height: 32)
        ],
      ),
    );
  }
}