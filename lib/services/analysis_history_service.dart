import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appbutawarna/core/config/cloudinary_config.dart';
import 'package:appbutawarna/features/riwayat/models/analysis_history.dart';

class AnalysisHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final CloudinaryPublic _cloudinary;

  AnalysisHistoryService() {
    _cloudinary = CloudinaryPublic(
      CloudinaryConfig.cloudName,
      CloudinaryConfig.uploadPreset,
      cache: false,
    );
  }

  // Upload gambar ke Cloudinary
  Future<String> _uploadImageToCloudinary(File imageFile) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imageFile.path,
          folder: 'colornt/analysis', // folder di Cloudinary
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } catch (e) {
      throw Exception('Gagal upload gambar: $e');
    }
  }

  // Simpan hasil analisis
  Future<void> saveAnalysis({
    required File imageFile,
    required String analysisResult,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    try {
      // 1. Upload gambar ke Cloudinary
      final imageUrl = await _uploadImageToCloudinary(imageFile);

      // 2. Simpan metadata ke Firestore
      final history = AnalysisHistory(
        id: '', // akan di-generate Firestore
        userId: user.uid,
        imageUrl: imageUrl,
        analysisResult: analysisResult,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('analysis_history')
          .add(history.toFirestore());
    } catch (e) {
      throw Exception('Gagal menyimpan riwayat: $e');
    }
  }

  // Ambil riwayat analisis user (terurut terbaru)
  Stream<List<AnalysisHistory>> getAnalysisHistory() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('analysis_history')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AnalysisHistory.fromFirestore(doc))
          .toList();
    });
  }

  // Hapus riwayat tertentu
  Future<void> deleteAnalysis(String historyId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('analysis_history')
          .doc(historyId)
          .delete();
    } catch (e) {
      throw Exception('Gagal menghapus riwayat: $e');
    }
  }
}