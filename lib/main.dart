import 'package:flutter/material.dart';
import 'package:appbutawarna/app.dart';
import 'package:appbutawarna/core/config/app_config.dart';
import 'package:appbutawarna/core/widgets/error_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  try {
    await AppConfig.initialize();
    runApp(const AppButaWarna());
  } catch (e) {
    print('Fatal error during initialization: $e');
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConfigErrorScreen(),
      ),
    );
  }
}