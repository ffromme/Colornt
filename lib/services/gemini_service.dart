import 'dart:async';

import 'package:appbutawarna/core/config/app_config.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY belum di set di file .env');
    }

    _model = GenerativeModel(
        model: 'gemini-2.5-flash-lite',
        apiKey: AppConfig.geminiApiKey,
        generationConfig: GenerationConfig(
          temperature: 0.4,
          topK: 32,
          topP: 1,
          maxOutputTokens: 1024,
        )
    );
  }

  Future<String> analyzeImage(File imageFile) async {
    try {
      final imageBytes = await imageFile.readAsBytes();

      final prompt = '''
        Anda adalah asisten analisis warna dalam aplikasi publik untuk membantu penyandang buta warna di Indonesia.

        Analisis gambar secara fokus pada objek yang paling menonjol dan relevan.
        Mulailah dengan objek utama, lalu lanjutkan ke objek pendukung yang secara visual penting.
        
        Jelaskan warna dengan bahasa alami dan mengalir, seolah Anda sedang membantu seseorang membayangkan isi gambar.
        
        Untuk setiap objek penting:
        - Sebutkan nama objek secara alami dalam kalimat
        - Jelaskan warna utama dan warna pendukung dengan nama warna spesifik dalam bahasa Indonesia
        - Sebutkan letak atau arah objek secara singkat jika membantu orientasi
        - Soroti kontras warna yang cukup jelas atau berpotensi sulit dibedakan
        
        Gunakan paragraf naratif singkat, bukan format laporan atau poin-poin.
        Hindari pengulangan frasa seperti “warna utama”, “warna pendukung”, atau “posisi”.
        
        Tidak perlu kalimat pembuka atau penutup.
        Panjang respons harus padat, informatif, dan nyaman dibaca, dengan gaya asisten manusia profesional, bukan mesin deskriptif.
      ''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(content);

      if (response.text == null || response.text!.trim().isEmpty) {
        return "Maaf, tidak bisa menganalisis gambar ini. Coba ambil foto lagi dengan pencahayaan yang lebih baik.";
      }

      return response.text!;

    } on SocketException {
      return 'Error: Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
    } on TimeoutException {
      return 'Error: Koneksi timeout. Coba lagi dengan koneksi yang lebih stabil.';
    } catch (e) {
      final errorMsg = e.toString().toLowerCase();

      if (errorMsg.contains('api key') || errorMsg.contains('invalid')) {
        return 'Error: API Key tidak valid. Silakan periksa konfigurasi.';
      } else if (errorMsg.contains('quota') || errorMsg.contains('limit')) {
        return 'Error: Kuota API habis. Silakan coba lagi nanti.';
      } else if (errorMsg.contains('permission')) {
        return 'Error: Tidak ada izin akses. Periksa permissions aplikasi.';
      } else {
        return 'Terjadi kesalahan: ${e.toString()}';
      }
    }
  }

  void dispose() {

  }
}