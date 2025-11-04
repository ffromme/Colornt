import 'package:flutter/material.dart';
import 'package:appbutawarna/app.dart';
import 'package:appbutawarna/core/config/app_config.dart';
import 'package:appbutawarna/core/widgets/error_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize app configuration
    await AppConfig.initialize();

    // Run app
    runApp(const AppButaWarna());
  } catch (e) {
    // Jika initialization gagal, tampilkan error screen
    print('Fatal error during initialization: $e');

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConfigErrorScreen(),
      ),
    );
  }
}