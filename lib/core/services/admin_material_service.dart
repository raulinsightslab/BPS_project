// lib/core/services/admin_material_service.dart
import 'package:bps_e_learning/core/models/material_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMaterialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get all materials (including unpublished) for admin
  Future<List<VideoItem>> getAllMaterials() async {
    try {
      final snapshot = await _firestore
          .collection('materials')
          .orderBy('order')
          .get();

      return snapshot.docs.map((doc) => VideoItem.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to load materials: $e');
    }
  }

  /// Add a new material
  Future<void> addMaterial(VideoItem item) async {
    try {
      final docRef = _firestore.collection('materials').doc();
      final newItem = VideoItem(
        id: docRef.id,
        order: item.order,
        title: item.title,
        description: item.description,
        youtubeId: item.youtubeId,
        program: item.program,
        isPublished: item.isPublished,
      );

      await docRef.set(newItem.toFirestore());
    } catch (e) {
      throw Exception('Failed to add material: $e');
    }
  }

  /// Update an existing material
  Future<void> updateMaterial(VideoItem item) async {
    try {
      await _firestore
          .collection('materials')
          .doc(item.id)
          .update(item.toFirestore());
    } catch (e) {
      throw Exception('Failed to update material: $e');
    }
  }

  /// Delete a material by ID
  Future<void> deleteMaterial(String id) async {
    try {
      await _firestore.collection('materials').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete material: $e');
    }
  }

  /// Get a single material by ID (for edit)
  Future<VideoItem?> getMaterialById(String id) async {
    try {
      final doc = await _firestore.collection('materials').doc(id).get();
      if (doc.exists) {
        return VideoItem.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load material: $e');
    }
  }
}
