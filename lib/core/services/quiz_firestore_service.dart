// lib/core/services/quiz_firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bps_e_learning/core/models/quiz_module_model.dart';
import 'package:bps_e_learning/core/models/quiz_model.dart';

class QuizFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get all published quiz modules for a specific program
  Future<List<QuizModuleModel>> getQuizModules(String program) async {
    try {
      final snapshot = await _firestore
          .collection('quiz_modules')
          .where('program', isEqualTo: program)
          .where('isPublished', isEqualTo: true)
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => QuizModuleModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load quiz modules: $e');
    }
  }

  /// Get all quiz questions for a specific module
  Future<List<QuizModel>> getQuizQuestions(String moduleId) async {
    try {
      final snapshot = await _firestore
          .collection('quizzes')
          .where('moduleId', isEqualTo: moduleId)
          .where('isPublished', isEqualTo: true)
          .orderBy('order')
          .get();

      return snapshot.docs
          .map((doc) => QuizModel.fromFirestore(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to load quiz questions: $e');
    }
  }

  /// Save quiz result to Firestore
  Future<void> saveQuizResult({
    required String moduleId,
    required String program,
    required int score,
    required int correctCount,
    required int totalQuestion,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      await _firestore.collection('quiz_results').add({
        'uid': user.uid,
        'moduleId': moduleId,
        'program': program,
        'score': score,
        'correctCount': correctCount,
        'totalQuestion': totalQuestion,
        'submittedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save quiz result: $e');
    }
  }

  /// Check if user has already completed a quiz module
  Future<bool> hasUserCompletedQuiz(String moduleId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final snapshot = await _firestore
          .collection('quiz_results')
          .where('uid', isEqualTo: user.uid)
          .where('moduleId', isEqualTo: moduleId)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get user's quiz result for a specific module
  Future<Map<String, dynamic>?> getUserQuizResult(String moduleId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final snapshot = await _firestore
          .collection('quiz_results')
          .where('uid', isEqualTo: user.uid)
          .where('moduleId', isEqualTo: moduleId)
          .orderBy('submittedAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      final data = snapshot.docs.first.data();
      return {
        'score': data['score'] ?? 0,
        'correctCount': data['correctCount'] ?? 0,
        'totalQuestion': data['totalQuestion'] ?? 0,
        'submittedAt': data['submittedAt'],
      };
    } catch (e) {
      return null;
    }
  }
}
