import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // Singleton pattern
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();
  factory SharedPrefsHelper() => _instance;
  SharedPrefsHelper._internal();

  SharedPreferences? _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Pastikan prefs sudah di-init
  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('SharedPreferences belum di-initialize! Panggil init() terlebih dahulu.');
    }
    return _prefs!;
  }

  // ==================== KUIS 1 ====================

  // Simpan skor terakhir
  Future<bool> saveKuis1LastScore(int score) async {
    return await prefs.setInt('kuis1_last_score', score);
  }

  // Ambil skor terakhir
  int getKuis1LastScore() {
    return prefs.getInt('kuis1_last_score') ?? 0;
  }

  // Simpan akurasi terakhir
  Future<bool> saveKuis1LastAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis1_last_accuracy', accuracy);
  }

  // Ambil akurasi terakhir
  double getKuis1LastAccuracy() {
    return prefs.getDouble('kuis1_last_accuracy') ?? 0.0;
  }

  // Simpan best score
  Future<bool> saveKuis1BestScore(int score) async {
    return await prefs.setInt('kuis1_best_score', score);
  }

  // Ambil best score
  int getKuis1BestScore() {
    return prefs.getInt('kuis1_best_score') ?? 0;
  }

  // Simpan best accuracy
  Future<bool> saveKuis1BestAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis1_best_accuracy', accuracy);
  }

  // Ambil best accuracy
  double getKuis1BestAccuracy() {
    return prefs.getDouble('kuis1_best_accuracy') ?? 0.0;
  }

  // Simpan jumlah kuis dimainkan
  Future<bool> saveKuis1PlayCount(int count) async {
    return await prefs.setInt('kuis1_play_count', count);
  }

  // Ambil jumlah kuis dimainkan
  int getKuis1PlayCount() {
    return prefs.getInt('kuis1_play_count') ?? 0;
  }

  // Increment play count
  Future<bool> incrementKuis1PlayCount() async {
    final currentCount = getKuis1PlayCount();
    return await saveKuis1PlayCount(currentCount + 1);
  }

  // Simpan timestamp terakhir main
  Future<bool> saveKuis1LastPlayed(String timestamp) async {
    return await prefs.setString('kuis1_last_played', timestamp);
  }

  // Ambil timestamp terakhir main
  String? getKuis1LastPlayed() {
    return prefs.getString('kuis1_last_played');
  }

  // Ambil semua data riwayat kuis 1
  Map<String, dynamic> getKuis1History() {
    return {
      'lastScore': getKuis1LastScore(),
      'lastAccuracy': getKuis1LastAccuracy(),
      'bestScore': getKuis1BestScore(),
      'bestAccuracy': getKuis1BestAccuracy(),
      'playCount': getKuis1PlayCount(),
      'lastPlayed': getKuis1LastPlayed(),
    };
  }

  // Reset semua data kuis 1
  Future<void> resetKuis1Data() async {
    await prefs.remove('kuis1_last_score');
    await prefs.remove('kuis1_last_accuracy');
    await prefs.remove('kuis1_best_score');
    await prefs.remove('kuis1_best_accuracy');
    await prefs.remove('kuis1_play_count');
    await prefs.remove('kuis1_last_played');
  }

  // ==================== KUIS 2 ====================

  // Simpan skor terakhir
  Future<bool> saveKuis2LastScore(int score) async {
    return await prefs.setInt('kuis2_last_score', score);
  }

  // Ambil skor terakhir
  int getKuis2LastScore() {
    return prefs.getInt('kuis2_last_score') ?? 0;
  }

  // Simpan akurasi terakhir
  Future<bool> saveKuis2LastAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis2_last_accuracy', accuracy);
  }

  // Ambil akurasi terakhir
  double getKuis2LastAccuracy() {
    return prefs.getDouble('kuis2_last_accuracy') ?? 0.0;
  }

  // Simpan best score
  Future<bool> saveKuis2BestScore(int score) async {
    return await prefs.setInt('kuis2_best_score', score);
  }

  // Ambil best score
  int getKuis2BestScore() {
    return prefs.getInt('kuis2_best_score') ?? 0;
  }

  // Simpan best accuracy
  Future<bool> saveKuis2BestAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis2_best_accuracy', accuracy);
  }

  // Ambil best accuracy
  double getKuis2BestAccuracy() {
    return prefs.getDouble('kuis2_best_accuracy') ?? 0.0;
  }

  // Simpan jumlah kuis dimainkan
  Future<bool> saveKuis2PlayCount(int count) async {
    return await prefs.setInt('kuis2_play_count', count);
  }

  // Ambil jumlah kuis dimainkan
  int getKuis2PlayCount() {
    return prefs.getInt('kuis2_play_count') ?? 0;
  }

  // Increment play count
  Future<bool> incrementKuis2PlayCount() async {
    final currentCount = getKuis2PlayCount();
    return await saveKuis2PlayCount(currentCount + 1);
  }

  // ==================== KUIS 3 ====================

  // Simpan skor terakhir
  Future<bool> saveKuis3LastScore(int score) async {
    return await prefs.setInt('kuis3_last_score', score);
  }

  // Ambil skor terakhir
  int getKuis3LastScore() {
    return prefs.getInt('kuis3_last_score') ?? 0;
  }

  // Simpan akurasi terakhir
  Future<bool> saveKuis3LastAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis3_last_accuracy', accuracy);
  }

  // Ambil akurasi terakhir
  double getKuis3LastAccuracy() {
    return prefs.getDouble('kuis3_last_accuracy') ?? 0.0;
  }

  // Simpan best score
  Future<bool> saveKuis3BestScore(int score) async {
    return await prefs.setInt('kuis3_best_score', score);
  }

  // Ambil best score
  int getKuis3BestScore() {
    return prefs.getInt('kuis3_best_score') ?? 0;
  }

  // Simpan best accuracy
  Future<bool> saveKuis3BestAccuracy(double accuracy) async {
    return await prefs.setDouble('kuis3_best_accuracy', accuracy);
  }

  // Ambil best accuracy
  double getKuis3BestAccuracy() {
    return prefs.getDouble('kuis3_best_accuracy') ?? 0.0;
  }

  // Simpan jumlah kuis dimainkan
  Future<bool> saveKuis3PlayCount(int count) async {
    return await prefs.setInt('kuis3_play_count', count);
  }

  // Ambil jumlah kuis dimainkan
  int getKuis3PlayCount() {
    return prefs.getInt('kuis3_play_count') ?? 0;
  }

  // Increment play count
  Future<bool> incrementKuis3PlayCount() async {
    final currentCount = getKuis3PlayCount();
    return await saveKuis3PlayCount(currentCount + 1);
  }

  // ==================== UTILITY ====================

  // Reset semua data aplikasi
  Future<void> resetAllData() async {
    await resetKuis1Data();
    await prefs.clear();
  }

  // Check apakah user first time
  Future<bool> isFirstTime() async {
    return prefs.getBool('is_first_time') ?? true;
  }

  // Set first time false
  Future<void> setNotFirstTime() async {
    await prefs.setBool('is_first_time', false);
  }
}