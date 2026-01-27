import 'package:cloud_firestore/cloud_firestore.dart';

class AnalysisHistory {
  final String id;
  final String userId;
  final String imageUrl; // URL dari Cloudinary
  final String analysisResult;
  final DateTime createdAt;

  AnalysisHistory({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.analysisResult,
    required this.createdAt,
  });

  // Convert dari Firestore
  factory AnalysisHistory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AnalysisHistory(
      id: doc.id,
      userId: data['userId'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      analysisResult: data['analysisResult'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert ke Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'analysisResult': analysisResult,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}