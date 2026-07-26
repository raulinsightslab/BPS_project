import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/services/video_firestore_service.dart';
import 'package:bps_e_learning/core/models/material_model.dart';
import 'video_player_screen.dart';

// ─── Colors ───────────────────────────────────────────────────────────────────
class _C {
  static const Color navy = Color(0xFF0A2A6B);
  static const Color navyLight = Color(0xFF1565C0);
  static const Color orange = Color(0xFFF29F05);
  static const Color orangeDark = Color(0xFFE65100);
  static const Color bg = Color(0xFFF0F4FA);
  static const Color cardBorder = Color(0xFFD6E4F7);

  // Thumb gradients per card index
  static const List<List<Color>> thumbGradients = [
    [Color(0xFF0D1B5E), Color(0xFF1A237E)],
    [Color(0xFF1A237E), Color(0xFF283593)],
    [Color(0xFF0A1540), Color(0xFF0D1B5E)],
    [Color(0xFF162040), Color(0xFF1A237E)],
  ];
}

// ─── DashboardScreen ──────────────────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  final String program;
  const DashboardScreen({super.key, required this.program});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openPlayer(
    BuildContext context,
    VideoItem video,
    List<VideoItem> allVideos,
    int index,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => VideoPlayerScreen(
          video: video,
          allVideos: allVideos,
          currentIndex: index,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Future<List<VideoItem>> _fetchVideos() async {
    return await _firestoreService.getMaterials(widget.program);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Column(
        children: [
          _Header(program: widget.program),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchVideos,
              color: _C.orange,
              child: FutureBuilder<List<VideoItem>>(
                future: _fetchVideos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: _C.orange),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red.shade300,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Gagal memuat video',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _C.navy,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            snapshot.error?.toString() ?? 'Terjadi kesalahan',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _C.orange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  final videos = snapshot.data ?? [];

                  if (videos.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library_rounded,
                            color: Color(0xFFB0BEC5),
                            size: 48,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Belum ada video tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _C.navy,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Program ini belum memiliki materi video',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    children: [
                      _SectionLabel(label: 'VIDEO MATERI'),
                      const SizedBox(height: 4),
                      ...videos.asMap().entries.map(
                        (e) => _VideoCard(
                          video: e.value,
                          index: e.key,
                          onTap: () =>
                              _openPlayer(context, e.value, videos, e.key),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final String program;

  const _Header({required this.program});

  String _getProgramDisplayName(String program) {
    switch (program) {
      case 'pojok_statistik':
        return 'Pojok Statistik';
      case 'desa_cantik':
        return 'Desa Cantik';
      case 'statistik_sektoral':
        return 'Statistik Sektoral';
      default:
        return program;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.navy, _C.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo row
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _C.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'PS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pojok Statistik',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'BPS Kabupaten Tangerang',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
              const Spacer(),
              // Video count will be updated by FutureBuilder
            ],
          ),
          const SizedBox(height: 20),
          // Headline with dynamic program name
          Text(
            'Modul Pembelajaran',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _getProgramDisplayName(program),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          // Stats row
          const Row(
            children: [
              _StatChip(
                icon: Icons.play_circle_outline_rounded,
                label: 'Video',
              ),
              SizedBox(width: 10),
              _StatChip(icon: Icons.access_time_rounded, label: 'Gratis'),
              SizedBox(width: 10),
              _StatChip(icon: Icons.verified_rounded, label: 'BPS Resmi'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _C.orange, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section Label ────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: _C.orange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _C.navy,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Video Card ───────────────────────────────────────────────────────────────
class _VideoCard extends StatelessWidget {
  final VideoItem video;
  final int index;
  final VoidCallback onTap;

  const _VideoCard({
    required this.video,
    required this.index,
    required this.onTap,
  });

  List<Color> get _gradient =>
      _C.thumbGradients[index % _C.thumbGradients.length];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _C.cardBorder, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: _C.navy.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildThumbnail(), _buildBody()],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 136,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // YouTube thumbnail
            Image.network(
              video.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _gradient[0].withValues(alpha: 0.72),
                    _gradient[1].withValues(alpha: 0.45),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Number badge
            Positioned(
              top: 10,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _C.orange,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  video.num,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            // Play icon center
            Center(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _C.orange.withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _C.orange.withValues(alpha: 0.45),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            // "Tonton" label bottom-right
            Positioned(
              bottom: 10,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Tap untuk tonton',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _C.navy,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            video.description,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF607D8B),
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Button row
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_C.orange, _C.orangeDark],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Tonton Video',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
