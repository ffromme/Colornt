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
        Anda adalah asisten yang diintegrasikan di aplikasi mobile untuk membantu penyandang buta warna di Indonesia. 
        Analisis gambar ini dengan detail tapi tetap ringkas. Beri penekanan deskripsi pada warna pada objek.
        Tidak perlu mengggunakan kalimat pembuka sebagai respon, langsung masuk ke analisis gambar.
        Sebutkan objek utama dengan deskripsi yang jelas, 
        lalu jelaskan semua warna yang terlihat dengan nama warna yang spesifik dalam bahasa Indonesia 
        (contoh: merah marun, biru langit, hijau daun muda). 
        Jelaskan posisi warna-warna tersebut di gambar 
        (kiri, kanan, atas, bawah, tengah), 
        serta jika ada pola atau perpaduan warna yang menonjol. 
        Akhiri dengan konteks singkat tentang suasana atau kemungkinan tempat dalam gambar. 
        Gunakan bahasa Indonesia yang mengalir seperti bercerita, tanpa membuat daftar. 
        Jangan terlalu panjang—jawaban harus padat, informatif, dan mudah dipahami. 
        Tidak perlu memberi kalimat pembuka, langsung saja bahas analisis warna dari foto yang terlihat.
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