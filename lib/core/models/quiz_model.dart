// lib/core/models/quiz_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  final String id;
  final String moduleId;
  final String question;

  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  final String correctAnswer;

  final int order;
  final bool isPublished;

  QuizModel({
    required this.id,
    required this.moduleId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
    required this.order,
    required this.isPublished,
  });

  List<String> get options => [optionA, optionB, optionC, optionD];

  factory QuizModel.fromFirestore(Map<String, dynamic> data, String id) {
    return QuizModel(
      id: id,
      moduleId: data['moduleId'] ?? '',
      question: data['question'] ?? '',
      optionA: data['optionA'] ?? '',
      optionB: data['optionB'] ?? '',
      optionC: data['optionC'] ?? '',
      optionD: data['optionD'] ?? '',
      correctAnswer: data['correctAnswer'] ?? '',
      order: data['order'] ?? 0,
      isPublished: data['isPublished'] ?? false,
    );
  }
}
