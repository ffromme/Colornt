import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';

class OnboardingNextButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingNextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        padding: EdgeInsets.zero,
        minimumSize: const Size(60, 60),
        shape: const CircleBorder(),
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
