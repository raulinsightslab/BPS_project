class VideoItem {
  final String title;
  final String videoId;
  final bool comingSoon;

  VideoItem({
    required this.title,
    required this.videoId,
    this.comingSoon = false,
  });
}
