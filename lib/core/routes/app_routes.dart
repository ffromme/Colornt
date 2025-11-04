import 'package:flutter/material.dart';
import 'package:appbutawarna/pages/onboarding.dart';
import 'package:appbutawarna/pages/home/homepage.dart';

class AppRoutes {
  static const String onboarding = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      onboarding: (context) => const Onboarding(),
      home: (context) => const Homepage(),
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