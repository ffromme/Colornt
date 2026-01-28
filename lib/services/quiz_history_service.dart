import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbutawarna/features/riwayat/models/quiz_history.dart';

class QuizHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metadata kuis (static)
  static const Map<String, Map<String, String>> quizMetadata = {
    'kuis1': {
      'name': 'Identifikasi Warna',
      'image': 'assets/images/kuis1.png',
    },
    'kuis2': {
      'name': 'Susun Gradasi Warna',
      'image': 'assets/images/kuis2.png',
    },
    'kuis3': {
      'name': 'Cari yang Berbeda',
      'image': 'assets/images/kuis3.png',
    },
  };

  // Simpan atau update hasil kuis
  Future<void> saveQuizResult({
    required String quizId,
    required int score,
    required double accuracy,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    try {
      final docRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('quiz_history')
          .doc(quizId);

      final doc = await docRef.get();

      if (doc.exists) {
        // Update existing record
        final data = doc.data()!;
        final currentBestScore = data['bestScore'] ?? 0;
        final currentBestAccuracy = (data['bestAccuracy'] ?? 0.0).toDouble();
        final currentPlayCount = data['playCount'] ?? 0;

        await docRef.update({
          'lastScore': score,
          'lastAccuracy': accuracy,
          'bestScore': score > currentBestScore ? score : currentBestScore,
          'bestAccuracy': accuracy > currentBestAccuracy ? accuracy : currentBestAccuracy,
          'playCount': currentPlayCount + 1,
          'lastPlayed': Timestamp.now(),
        });
      } else {
        // Create new record
        await docRef.set({
          'userId': user.uid,
          'lastScore': score,
          'lastAccuracy': accuracy,
          'bestScore': score,
          'bestAccuracy': accuracy,
          'playCount': 1,
          'lastPlayed': Timestamp.now(),
        });
      }
    } catch (e) {
      throw Exception('Gagal menyimpan riwayat kuis: $e');
    }
  }

  // Ambil riwayat semua kuis user
  Stream<List<QuizHistory>> getAllQuizHistory() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('quiz_history')
        .snapshots()
        .map((snapshot) {
      final histories = <QuizHistory>[];

      for (var quizId in quizMetadata.keys) {
        final metadata = quizMetadata[quizId]!;

        // Cari doc dengan quizId tertentu
        try {
          final doc = snapshot.docs.firstWhere((d) => d.id == quizId);

          // Doc ditemukan, parse data
          histories.add(
            QuizHistory.fromFirestore(
              doc,
              metadata['name']!,
              metadata['image']!,
            ),
          );
        } catch (e) {
          // Doc tidak ditemukan, buat empty history
          histories.add(
            QuizHistory(
              quizId: quizId,
              userId: user.uid,
              quizName: metadata['name']!,
              quizImage: metadata['image']!,
              lastScore: 0,
              lastAccuracy: 0.0,
              bestScore: 0,
              bestAccuracy: 0.0,
              playCount: 0,
              lastPlayed: null,
            ),
          );
        }
      }

      return histories;
    });
  }

  // Ambil riwayat 1 kuis spesifik
  Future<QuizHistory> getQuizHistoryById(String quizId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    final metadata = quizMetadata[quizId];
    if (metadata == null) {
      throw Exception('Quiz ID tidak valid');
    }

    try {
      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('quiz_history')
          .doc(quizId)
          .get();

      if (doc.exists) {
        return QuizHistory.fromFirestore(
          doc,
          metadata['name']!,
          metadata['image']!,
        );
      } else {
        // Return empty history jika belum ada data
        return QuizHistory(
          quizId: quizId,
          userId: user.uid,
          quizName: metadata['name']!,
          quizImage: metadata['image']!,
          lastScore: 0,
          lastAccuracy: 0.0,
          bestScore: 0,
          bestAccuracy: 0.0,
          playCount: 0,
          lastPlayed: null,
        );
      }
    } catch (e) {
      // Return empty history jika error
      return QuizHistory(
        quizId: quizId,
        userId: user.uid,
        quizName: metadata['name']!,
        quizImage: metadata['image']!,
        lastScore: 0,
        lastAccuracy: 0.0,
        bestScore: 0,
        bestAccuracy: 0.0,
        playCount: 0,
        lastPlayed: null,
      );
    }
  }

  // Reset riwayat kuis tertentu (opsional)
  Future<void> deleteQuizHistory(String quizId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('quiz_history')
          .doc(quizId)
          .delete();
    } catch (e) {
      throw Exception('Gagal menghapus riwayat: $e');
    }
  }
}