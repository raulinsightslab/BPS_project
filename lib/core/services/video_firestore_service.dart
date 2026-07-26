import 'package:bps_e_learning/core/models/material_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all published materials for a specific program
  Future<List<VideoItem>> getMaterials(String program) async {
    try {
      final snapshot = await _firestore
          .collection('materials')
          .where('program', isEqualTo: program)
          .where('isPublished', isEqualTo: true)
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) => VideoItem.fromFirestore(doc)).toList();
    } catch (e) {
      // Re-throw with a more descriptive message
      throw Exception('Failed to load materials: $e');
    }
  }

  /// Get a single video by ID
  Future<VideoItem?> getVideoById(String id) async {
    try {
      final doc = await _firestore.collection('materials').doc(id).get();
      if (doc.exists) {
        return VideoItem.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load video: $e');
    }
  }

  /// Get all videos (all programs) - useful for admin or debugging
  Future<List<VideoItem>> getAllMaterials() async {
    try {
      final snapshot = await _firestore
          .collection('materials')
          .where('isPublished', isEqualTo: true)
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) => VideoItem.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load materials: $e');
    }
  }
}
