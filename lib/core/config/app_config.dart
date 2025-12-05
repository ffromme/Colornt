import 'package:appbutawarna/features/kuisWarna/shared/shared_prefs_helper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class AppConfig {
  static String? _geminiApiKey;

  static String get geminiApiKey {
    if (_geminiApiKey == null || _geminiApiKey!.isEmpty) {
      throw Exception('Gemini API Key belum diinisialisasi');
    }
    return _geminiApiKey!;
  }

  /// Initialize app configuration
  static Future<void> initialize() async {
    try {
      // Initialize SharedPreferences
      await SharedPrefsHelper().init();

      // Load environment variables
      await _loadEnvVariables();

      // Initialize Firebase (opsional, jika masih digunakan)
      await _initializeFirebase();

      print('✅ App configuration berhasil diinisialisasi');
    } catch (e) {
      print('❌ Error initializing app: $e');
      rethrow; // Re-throw untuk ditangani di main
    }
  }

  /// Load .env file
  static Future<void> _loadEnvVariables() async {
    try {
      await dotenv.load(fileName: ".env");

      _geminiApiKey = dotenv.env['GEMINI_API_KEY'];

      if (_geminiApiKey == null || _geminiApiKey!.isEmpty) {
        throw Exception(
            'GEMINI_API_KEY tidak ditemukan di file .env\n'
                'Pastikan file .env ada dan berisi: GEMINI_API_KEY=your_key'
        );
      }

      print('✅ Environment variables loaded successfully');
    } catch (e) {
      throw Exception('Error loading .env: $e');
    }
  }

  /// Initialize Firebase
  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase initialized successfully');
    } catch (e) {
      print('⚠️ Firebase initialization failed: $e');
    }
  }
}