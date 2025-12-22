import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bps_e_learning/model/modul_model.dart';
import 'package:bps_e_learning/model/video_item.dart';

class VideoPage extends StatefulWidget {
  final LessonModel lesson;

  const VideoPage({super.key, required this.lesson});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _ytController;
  late VideoItem _selectedVideo;

  @override
  void initState() {
    super.initState();

    _selectedVideo = widget.lesson.videos.firstWhere(
      (v) => !v.comingSoon,
      orElse: () => widget.lesson.videos.first,
    );

    _ytController = YoutubePlayerController(
      initialVideoId: _selectedVideo.videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: true),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  // ======================
  // CONVERT GOOGLE DRIVE LINK → DIRECT DOWNLOAD
  // ======================
  String _convertDriveLink(String url) {
    if (!url.contains("drive.google.com")) return url;

    final uri = Uri.parse(url);
    final fileId = uri.pathSegments.contains("d")
        ? uri.pathSegments[uri.pathSegments.indexOf("d") + 1]
        : uri.queryParameters["id"];

    return "https://drive.google.com/uc?export=download&id=$fileId";
  }

  // ======================
  // DOWNLOAD PDF
  // ======================
  Future<void> _downloadPdf(String url) async {
    final downloadUrl = _convertDriveLink(url);
    final uri = Uri.parse(downloadUrl);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Gagal mendownload PDF")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _ytController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFFF8A00),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              widget.lesson.title,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF005BBB),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(16), child: player),

              const SizedBox(height: 20),

              Text(
                widget.lesson.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Daftar Video",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),

              // ======================
              // LIST VIDEO
              // ======================
              ...widget.lesson.videos.map((video) {
                final isActive = video == _selectedVideo;

                return InkWell(
                  onTap: video.comingSoon
                      ? null
                      : () {
                          setState(() {
                            _selectedVideo = video;
                            _ytController.load(video.videoId);
                          });
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.orange.shade100
                          : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          video.comingSoon
                              ? Icons.lock_outline
                              : Icons.play_circle_fill_rounded,
                          color: const Color(0xFFFF8A00),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            video.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: video.comingSoon
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (video.comingSoon)
                          const Text(
                            "Coming Soon",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 30),

              // ======================
              // DOWNLOAD PDF BUTTON
              // ======================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: widget.lesson.pdfUrl.isEmpty
                      ? null
                      : () => _downloadPdf(widget.lesson.pdfUrl),
                  icon: const Icon(Icons.download_rounded),
                  label: const Text("Download Modul PDF"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8A00),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
