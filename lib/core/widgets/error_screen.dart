import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  final String? details;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    this.title = 'Terjadi Kesalahan',
    required this.message,
    this.details,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 100,
                  color: HexColor('#E74C3C'),
                ),
                const SizedBox(height: 32),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                if (details != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      details!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
                if (onRetry != null) ...[
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#1ABC9C'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk error konfigurasi
class ConfigErrorScreen extends ErrorScreen {
  const ConfigErrorScreen({super.key})
      : super(
    title: 'Konfigurasi Error',
    message: 'API Key tidak ditemukan atau tidak valid',
    details: 'Langkah-langkah:\n'
        '1. Buat file .env di root project\n'
        '2. Isi dengan: GEMINI_API_KEY=your_key\n'
        '3. Tambahkan .env di pubspec.yaml\n'
        '4. Jalankan: flutter pub get\n'
        '5. Restart aplikasi',
  );
}