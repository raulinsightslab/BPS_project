import 'package:cloud_firestore/cloud_firestore.dart';

class VideoItem {
  final String id;
  final int order;
  final String title;
  final String description;
  final String youtubeId;
  final String program;
  final bool isPublished;

  const VideoItem({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required this.youtubeId,
    required this.program,
    required this.isPublished,
  });

  /// Nomor yang ditampilkan di UI (01, 02, 03...)
  String get num => order.toString().padLeft(2, '0');

  /// URL YouTube
  String get url => "https://www.youtube.com/watch?v=$youtubeId";

  /// Thumbnail YouTube
  String get thumbnailUrl =>
      "https://img.youtube.com/vi/$youtubeId/mqdefault.jpg";

  factory VideoItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return VideoItem(
      id: doc.id,
      order: data['order'] ?? 0,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      youtubeId: data['youtubeId'] ?? '',
      program: data['program'] ?? '',
      isPublished: data['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'youtubeId': youtubeId,
      'program': program,
      'order': order,
      'isPublished': isPublished,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
