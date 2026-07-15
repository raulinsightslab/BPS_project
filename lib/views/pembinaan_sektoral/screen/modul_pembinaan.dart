import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

const Color _primaryBlue = Color(0xff0A3A75);
const Color _primaryLight = Color(0xff1A5BA8);
const Color _cardBorder = Color(0xffE2E8F0);
const Color _textDark = Color(0xff1E293B);
const Color _textGrey = Color(0xff64748B);

class PembinaanModulScreen extends StatelessWidget {
  const PembinaanModulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFE),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Modul Pembinaan Sektoral',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 3,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xff4A90E2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'DAFTAR MODUL PEMBELAJARAN',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _primaryBlue,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildModuleCard(
              title: 'Evaluasi Penyelenggaraan Statistik Sektoral (EPSS)',
              description:
                  'Evaluasi atas pelaksanaan penyelenggaraan statistik sektoral untuk meningkatkan kualitas dan tata kelola data.',
              icon: Icons.assessment_outlined,
              color: Colors.blue,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
              onTap: () => _openVideoPage(
                context,
                'EPSS',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Identifikasi Kegiatan Statistik',
              description:
                  'Mengidentifikasi kegiatan statistik dalam instansi untuk memastikan kesesuaian dengan standar dan kebutuhan nasional.',
              icon: Icons.search_outlined,
              color: Colors.green,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFunflies.mp4',
              onTap: () => _openVideoPage(
                context,
                'Identifikasi Kegiatan Statistik',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFunflies.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Satu Data Indonesia',
              description:
                  'Pemahaman prinsip, peran, dan pelaksanaan Satu Data Indonesia dalam pengelolaan data pemerintah.',
              icon: Icons.data_usage_outlined,
              color: Colors.orange,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
              onTap: () => _openVideoPage(
                context,
                'Satu Data Indonesia',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Kualitas Data',
              description:
                  'Standar dan tahapan peningkatan kualitas data agar memenuhi kaidah statistik yang baik.',
              icon: Icons.verified_outlined,
              color: Colors.purple,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
              onTap: () => _openVideoPage(
                context,
                'Kualitas Data',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Proses Bisnis Statistik',
              description:
                  'Penjelasan alur kegiatan statistik mulai dari perencanaan hingga diseminasi.',
              icon: Icons.loop_outlined,
              color: Colors.teal,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
              onTap: () => _openVideoPage(
                context,
                'Proses Bisnis Statistik',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Kelembagaan Statistik',
              description:
                  'Struktur, peran, dan koordinasi kelembagaan dalam penyelenggaraan statistik.',
              icon: Icons.account_balance_outlined,
              color: Colors.red,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCar.mp4',
              onTap: () => _openVideoPage(
                context,
                'Kelembagaan Statistik',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCar.mp4',
              ),
            ),
            _buildModuleCard(
              title: 'Sistem Statistik Nasional (SSN)',
              description:
                  'Gambaran sistem statistik nasional sebagai kerangka integrasi statistik di Indonesia.',
              icon: Icons.public_outlined,
              color: Colors.indigo,
              videoUrl:
                  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
              onTap: () => _openVideoPage(
                context,
                'Sistem Statistik Nasional',
                'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _openVideoPage(BuildContext context, String title, String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VideoPlayerScreen(title: title, videoUrl: videoUrl),
      ),
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String videoUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: _primaryBlue.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 14,
                          color: _primaryBlue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Putar Video',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── VIDEO PLAYER SCREEN (IN-APP) ────────────────────────────────────────────
class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String videoUrl;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    await _controller.initialize();
    _controller.setLooping(true);

    setState(() {
      _isInitialized = true;
    });
  }

  void _playPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.fullscreen),
            onPressed: () {
              // Fullscreen functionality can be added here
            },
          ),
        ],
      ),
      body: _isInitialized
          ? Column(
              children: [
                // Video Player
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      // Custom play/pause overlay
                      if (!_controller.value.isPlaying)
                        GestureDetector(
                          onTap: _playPause,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.play_arrow,
                              size: 64,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      // Video controls overlay on tap
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _playPause,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.7),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                  onPressed: _playPause,
                                ),
                                Expanded(
                                  child: VideoProgressIndicator(
                                    _controller,
                                    allowScrubbing: true,
                                    colors: VideoProgressColors(
                                      playedColor: _primaryBlue,
                                      bufferedColor: Colors.grey,
                                      backgroundColor: Colors.grey.shade800,
                                    ),
                                  ),
                                ),
                                Text(
                                  _formatDuration(_controller.value.position),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDuration(_controller.value.duration),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Video Info
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _primaryBlue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Text(
                                'Modul Pembelajaran',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 16,
                            ),
                            const Text(
                              ' Resmi BPS',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 15),
                        const Text(
                          'Deskripsi Modul:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Modul ini berisi materi pembelajaran tentang ${widget.title}. '
                          'Video ini disediakan oleh BPS sebagai bagian dari program '
                          'Pembinaan Statistik Sektoral untuk meningkatkan kualitas '
                          'data statistik di lingkungan pemerintah daerah.',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryBlue),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Memuat video...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }
}
