import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryConfig {
  static String get cloudName {
    final name = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    if (name == null || name.isEmpty) {
      throw Exception('CLOUDINARY_CLOUD_NAME tidak ditemukan di .env');
    }
    return name;
  }

  static String get uploadPreset {
    final preset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'];
    if (preset == null || preset.isEmpty) {
      throw Exception('CLOUDINARY_UPLOAD_PRESET tidak ditemukan di .env');
    }
    return preset;
  }
}