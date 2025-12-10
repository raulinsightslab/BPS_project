class ModuleModel {
  final String title;
  final List<LessonModel> lessons;

  ModuleModel({required this.title, required this.lessons});
}

class LessonModel {
  final String title;
  final String videoId;
  final String description;
  final String pdfUrl;

  LessonModel({
    required this.title,
    required this.videoId,
    required this.description,
    required this.pdfUrl,
    x,
  });
}
