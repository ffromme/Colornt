import 'package:appbutawarna/features/kuisWarna/kuis1/kuis1_instruction.dart';
import 'package:appbutawarna/features/kuisWarna/kuis2/kuis2_instruction.dart';
import 'package:appbutawarna/features/kuisWarna/kuis3/kuis3_instruction.dart';
import 'package:flutter/material.dart';
import 'package:appbutawarna/features/onboarding/onboarding_view.dart';
import 'package:appbutawarna/features/main_page.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';
  static const String kuis1Instruction = '/kuis1_instruction';
  static const String kuis2Instruction = '/kuis2_instruction';
  static const String kuis3Instruction = '/kuis3_instruction';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const OnboardingView(),
      home: (context) => const MainPage(),
      kuis1Instruction: (context) => const Kuis1Instruction(),
      kuis2Instruction: (context) => const Kuis2Instruction(),
      kuis3Instruction: (context) => const Kuis3Instruction(),
    };
  }

  // Navigation helpers
  static Future<void> navigateToHome(BuildContext context) {
    return Navigator.pushReplacementNamed(context, home);
  }

  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }
}