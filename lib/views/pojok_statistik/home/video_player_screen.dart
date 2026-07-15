import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dashboard_screen.dart'; // for VideoItem

// ─── Colors (local copy so file is self-contained) ────────────────────────────
class _C {
  static const Color navy = Color(0xFF0A2A6B);
  static const Color navyLight = Color(0xFF1565C0);
  static const Color orange = Color(0xFFF29F05);
  static const Color orangeDark = Color(0xFFE65100);
  static const Color bg = Color(0xFFF0F4FA);
  static const Color cardBorder = Color(0xFFD6E4F7);

  static const List<List<Color>> thumbGradients = [
    [Color(0xFF0D1B5E), Color(0xFF1A237E)],
    [Color(0xFF1A237E), Color(0xFF283593)],
    [Color(0xFF0A1540), Color(0xFF0D1B5E)],
    [Color(0xFF162040), Color(0xFF1A237E)],
  ];
}

// ─── VideoPlayerScreen ────────────────────────────────────────────────────────
class VideoPlayerScreen extends StatefulWidget {
  final VideoItem video;
  final List<VideoItem> allVideos;
  final int currentIndex;

  const VideoPlayerScreen({
    super.key,
    required this.video,
    required this.allVideos,
    required this.currentIndex,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;
  late VideoItem _currentVideo;
  late int _currentIndex;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _currentVideo = widget.video;
    _currentIndex = widget.currentIndex;
    _initController(_currentVideo.youtubeId);
  }

  void _initController(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }

  void _switchVideo(VideoItem video, int index) {
    _controller.pause();
    _controller.load(video.youtubeId);
    setState(() {
      _currentVideo = video;
      _currentIndex = index;
    });
    // Scroll back to top when switching
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  List<MapEntry<int, VideoItem>> get _relatedVideos {
    return widget.allVideos
        .asMap()
        .entries
        .where((e) => e.key != _currentIndex)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        setState(() => _isFullScreen = true);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      },
      onExitFullScreen: () {
        setState(() => _isFullScreen = false);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: _C.orange,
        progressColors: const ProgressBarColors(
          playedColor: _C.orange,
          handleColor: _C.orange,
          bufferedColor: Color(0xFFBBDEFB),
          backgroundColor: Color(0xFFE3F0FF),
        ),
        onReady: () => _controller.play(),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: _C.bg,
          body: Column(
            children: [
              // App bar (hide in fullscreen)
              if (!_isFullScreen) _buildAppBar(context),
              // YouTube player (always visible, takes fullscreen when needed)
              Container(color: Colors.black, child: player),
              // Content below player (hide in fullscreen)
              if (!_isFullScreen)
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildVideoInfo(),
                        _buildDivider(),
                        _buildRelatedSection(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // ── App Bar ────────────────────────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: _C.navy,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.of(context).padding.top + 10,
        16,
        14,
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Video Materi',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  _currentVideo.num + '. ' + _currentVideo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Video Info ─────────────────────────────────────────────────────────────
  Widget _buildVideoInfo() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.cardBorder, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: _C.navy.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Num badge + title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: _C.orange,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  _currentVideo.num,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _currentVideo.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _C.navy,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Divider
          Container(height: 0.5, color: _C.cardBorder),
          const SizedBox(height: 10),
          // Description
          Text(
            _currentVideo.description,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF607D8B),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          // Tag row
          Row(
            children: [
              _Tag(label: 'BPS', isPrimary: true),
              const SizedBox(width: 6),
              _Tag(label: 'Statistik', isPrimary: false),
              const Spacer(),
              // Video number indicator
              Text(
                '${_currentIndex + 1} / ${widget.allVideos.length}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF90A4AE),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Divider ────────────────────────────────────────────────────────────────
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
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
          const Text(
            'MATERI LAINNYA',
            style: TextStyle(
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

  // ── Related Videos ─────────────────────────────────────────────────────────
  Widget _buildRelatedSection() {
    final related = _relatedVideos;
    return Column(
      children: related.map((entry) {
        return _RelatedItem(
          video: entry.value,
          index: entry.key,
          isCurrentlyPlaying: false,
          onTap: () => _switchVideo(entry.value, entry.key),
        );
      }).toList(),
    );
  }
}

// ─── Tag Chip ────────────────────────────────────────────────────────────────
class _Tag extends StatelessWidget {
  final String label;
  final bool isPrimary;
  const _Tag({required this.label, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary
            ? const Color(0xFFE3F0FF)
            : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isPrimary ? _C.navyLight : _C.orangeDark,
        ),
      ),
    );
  }
}

// ─── Related Video Item ───────────────────────────────────────────────────────
class _RelatedItem extends StatelessWidget {
  final VideoItem video;
  final int index;
  final bool isCurrentlyPlaying;
  final VoidCallback onTap;

  const _RelatedItem({
    required this.video,
    required this.index,
    required this.isCurrentlyPlaying,
    required this.onTap,
  });

  List<Color> get _gradient =>
      _C.thumbGradients[index % _C.thumbGradients.length];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.cardBorder, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: _C.navy.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 72,
                height: 50,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
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
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
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
                    // Overlay
                    Container(color: _gradient[0].withValues(alpha: 0.45)),
                    // Play icon
                    const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    // Num badge
                    Positioned(
                      bottom: 3,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: _C.orange,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          video.num,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _C.navy,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pojok Statistik · BPS',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF90A4AE),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: _C.navy,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
