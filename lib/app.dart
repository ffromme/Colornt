import 'package:appbutawarna/features/kuisWarna/kuis1/providers/kuis1_provider.dart';
import 'package:flutter/material.dart';
import 'package:appbutawarna/core/theme/app_theme.dart';
import 'package:appbutawarna/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

class AppButaWarna extends StatelessWidget {
  const AppButaWarna({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Kuis1Provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Colorn\'t - Asisten Warna',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.onboarding,
        routes: AppRoutes.routes,
      ),
    );
  }
}