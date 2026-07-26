// lib/core/models/quiz_module_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModuleModel {
  final String id;
  final String moduleId;
  final String title;
  final String description;
  final String program;
  final int order;
  final int totalQuestion;
  final bool isPublished;

  const QuizModuleModel({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.description,
    required this.program,
    required this.order,
    required this.totalQuestion,
    required this.isPublished,
  });

  String get num => order.toString().padLeft(2, '0');

  factory QuizModuleModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return QuizModuleModel(
      id: doc.id,
      moduleId: data['moduleId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      program: data['program'] ?? '',
      order: data['order'] ?? 0,
      totalQuestion: data['totalQuestion'] ?? 0,
      isPublished: data['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'moduleId': moduleId,
      'program': program,
      'order': order,
      'totalQuestion': totalQuestion,
      'isPublished': isPublished,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
