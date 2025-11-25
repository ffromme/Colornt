import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';

class OnboardingDescription extends StatelessWidget {
  final String description;

  const OnboardingDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 16,
        color: AppTheme.textSecondary,
      ),
    );
  }
}
