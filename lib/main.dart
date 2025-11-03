import 'package:appbutawarna/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY tidak ditemukan di file .env');
    }
    print('API Key berhasil di-load');
  } catch (e) {
    print('Error loading .env: $e');
    print('Pastikan file .env ada di root project dan terdaftar di pubspec.yaml');
    runApp(const ErrorApp(error: 'File .env tidak ditemukan atau API key kosong'));
    return;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AppButaWarna());
}

class AppButaWarna extends StatelessWidget {
  const AppButaWarna({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Buta Warna',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Plus Jakarta Sans',
      ),
      home: Onboarding(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;

  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 80,
                  color: Colors.red,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Konfigurasi Error',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Langkah-langkah:\n'
                      '1. Buat file .env di root project\n'
                      '2. Isi dengan: GEMINI_API_KEY=your_key\n'
                      '3. Tambahkan .env di pubspec.yaml (bagian assets)\n'
                      '4. Jalankan: flutter pub get\n'
                      '5. Run ulang aplikasi',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}