import 'video_item.dart';

class ModuleModel {
  final String title;
  final List<LessonModel> lessons;

  ModuleModel({required this.title, required this.lessons});
}

class LessonModel {
  final String title;
  final String description;
  final String pdfUrl;
  final List<VideoItem> videos;

  LessonModel({
    required this.title,
    required this.description,
    required this.pdfUrl,
    required this.videos,
  });
}
