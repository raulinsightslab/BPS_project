import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DesaModulPage extends StatefulWidget {
  const DesaModulPage({super.key});

  @override
  State<DesaModulPage> createState() => _DesaModulPageState();
}

class _DesaModulPageState extends State<DesaModulPage> {
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();

    // VIDEO ID (AMAN, ANTI FORCE CLOSE)
    const String videoId = "2Vv-BfVoq4g";

    _ytController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _ytController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.orange,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF3E0),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "Modul Pembelajaran",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange.shade900,
                  ),
                ),

                const SizedBox(height: 20),

                // =======================
                // VIDEO PLAYER BOX
                // =======================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(blurRadius: 8, color: Colors.orange.shade200),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Video Pembelajaran Desa Cantik",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      AspectRatio(aspectRatio: 16 / 9, child: player),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                _buildCard("Pengenalan Statistik Dasar"),
                _buildCard("Cara Input Data Potensi Desa"),
                _buildCard("Pengenalan Visualisasi Data"),
                _buildCard("Pemanfaatan Publikasi BPS"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.orange.shade200, blurRadius: 8)],
      ),
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }
}
