import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/core/routes/app_routes.dart';

class AppButaWarna extends StatelessWidget {
  const AppButaWarna({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colorn\'t - Asisten Warna',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.routes,
    );
  }
}