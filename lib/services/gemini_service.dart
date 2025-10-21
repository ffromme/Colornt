import 'dart:async';

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
        model: 'gemini-2.0-flash-lite',
        apiKey: apiKey,
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
        Anda adalah asisten untuk penyandang buta warna di Indonesia. 
        Analisis gambar ini dengan detail tapi tetap ringkas, tidak perlu dibuat daftar poin:

        1. **Objek Utama**: Sebutkan objek utama yang terlihat
        2. **Warna-Warna**: Jelaskan SEMUA warna yang ada dengan nama warna yang sangat spesifik dalam bahasa Indonesia
           - Contoh: "merah marun", "biru langit cerah", "hijau daun muda", "kuning keemasan"
        3. **Posisi Warna**: Jelaskan di mana warna-warna tersebut berada (kiri, kanan, atas, bawah, tengah)
        4. **Pola/Kombinasi**: Jika ada pola atau kombinasi warna menarik, jelaskan
        5. **Konteks**: Berikan konteks tambahan yang membantu memahami gambar
        
        Gunakan bahasa Indonesia yang natural dan mudah dipahami. 
        Format jawaban seperti bercerita, bukan bullet points.
        Mulai dengan kalimat yang menarik.
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