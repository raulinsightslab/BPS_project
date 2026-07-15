import 'package:bps_e_learning/views/desa_cantik/screen/learning_descan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ─── Video Player Screen ───────────────────────────────────────────────────────
class DesaCantikVideoListScreen extends StatefulWidget {
  final ModuleItem module;
  final int initialVideoIndex;

  const DesaCantikVideoListScreen({
    super.key,
    required this.module,
    this.initialVideoIndex = 0,
  });

  @override
  State<DesaCantikVideoListScreen> createState() =>
      _DesaCantikVideoListScreenState();
}

class _DesaCantikVideoListScreenState extends State<DesaCantikVideoListScreen>
    with WidgetsBindingObserver {
  late int _currentVideoIndex;
  YoutubePlayerController? _controller;
  bool _isFullscreen = false;
  final Set<int> _watchedIndices = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // CRITICAL FIX: Start from the given index (preserves video position when re-entering)
    int startIndex = widget.initialVideoIndex;

    // Only find first available if the initial index is invalid
    if (startIndex < 0 || startIndex >= widget.module.videos.length) {
      startIndex = 0;
    }

    final v = widget.module.videos[startIndex];
    if (v.comingSoon || v.videoId.isEmpty) {
      startIndex = widget.module.videos.indexWhere(
        (v) => !v.comingSoon && v.videoId.isNotEmpty,
      );
      if (startIndex == -1) startIndex = 0;
    }
    _currentVideoIndex = startIndex;

    _initController(_currentVideoIndex);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // ── Controller helpers ────────────────────────────────────────────────────

  void _initController(int index) {
    final video = widget.module.videos[index];
    if (video.comingSoon || video.videoId.isEmpty) return;

    _controller?.dispose();
    _controller = YoutubePlayerController(
      initialVideoId: video.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        disableDragSeek: false,
        showLiveFullscreenButton: true,
      ),
    )..addListener(_onControllerUpdate);
  }

  bool _didEndFired = false;

  void _onControllerUpdate() {
    if (_controller == null) return;
    final val = _controller!.value;

    // Mark as watched once it starts playing
    if (val.isPlaying && !_watchedIndices.contains(_currentVideoIndex)) {
      // We consider a video "watched" when it ends
    }

    // Detect video ended
    if (val.playerState == PlayerState.ended && !_didEndFired) {
      _didEndFired = true;
      _onVideoEnded();
    }

    // Reset flag when playing again
    if (val.playerState == PlayerState.playing) {
      _didEndFired = false;
    }
  }

  void _onVideoEnded() {
    if (!mounted) return;

    // Mark current video as watched
    setState(() {
      _watchedIndices.add(_currentVideoIndex);
    });

    // Check if all available videos in this module are watched
    final availableIndices = widget.module.videos
        .asMap()
        .entries
        .where((e) => !e.value.comingSoon && e.value.videoId.isNotEmpty)
        .map((e) => e.key)
        .toList();

    final allWatched = availableIndices.every(
      (i) => _watchedIndices.contains(i),
    );

    if (allWatched) {
      _showCompletionDialog();
      return;
    }

    // Go to next available video
    final nextIndex = _findNextAvailableVideo(_currentVideoIndex);
    if (nextIndex != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _switchVideo(nextIndex);
      });
    }
  }

  int? _findNextAvailableVideo(int fromIndex) {
    for (int i = fromIndex + 1; i < widget.module.videos.length; i++) {
      final v = widget.module.videos[i];
      if (!v.comingSoon && v.videoId.isNotEmpty) return i;
    }
    return null;
  }

  void _switchVideo(int index) {
    if (index == _currentVideoIndex) return;
    final video = widget.module.videos[index];
    if (video.comingSoon || video.videoId.isEmpty) return;

    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    _controller = null;

    setState(() {
      _currentVideoIndex = index;
      _didEndFired = false;
    });

    _initController(index);
    setState(() {});
  }

  void _showCompletionDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: DesaCColors.accentGreen.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: DesaCColors.accentGreen,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Selamat! 🎉',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: DesaCColors.accentGreen,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Anda telah berhasil menyelesaikan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: DesaCColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Modul ${widget.module.num} – ${widget.module.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: DesaCColors.textPrimary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: DesaCColors.accentGreen.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Tonton Ulang',
                        style: TextStyle(
                          color: DesaCColors.accentGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DesaCColors.accentGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _downloadPdf() async {
    final url = widget.module.pdfUrl;
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tidak dapat membuka link PDF')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal membuka PDF')));
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller?.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    _controller = null;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final currentVideo = widget.module.videos[_currentVideoIndex];
    final canPlay = !currentVideo.comingSoon && currentVideo.videoId.isNotEmpty;
    final accentColor = widget.module.accentColor;

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller:
            _controller ??
            YoutubePlayerController(
              initialVideoId: '',
              flags: const YoutubePlayerFlags(autoPlay: false),
            ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: accentColor,
        progressColors: ProgressBarColors(
          playedColor: accentColor,
          handleColor: accentColor,
        ),
        onReady: () {},
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: DesaCColors.bg,
          appBar: _isFullscreen
              ? null
              : AppBar(
                  backgroundColor: DesaCColors.primary,
                  elevation: 0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: DesaCColors.primary,
                    statusBarBrightness: Brightness.light,
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modul ${widget.module.num}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        widget.module.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            '${_watchedIndices.length}/${_availableVideoCount} selesai',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          body: Column(
            children: [
              // Video Player area
              if (canPlay && _controller != null)
                player
              else
                _buildPlaceholder(currentVideo),

              // Rest of content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current video title + info
                      _buildVideoInfo(currentVideo, accentColor),

                      // Download PDF button
                      _buildDownloadButton(),

                      // Progress bar
                      _buildProgressBar(accentColor),

                      // Playlist label
                      _buildPlaylistLabel(accentColor),

                      // Playlist items
                      _buildPlaylist(accentColor),

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

  int get _availableVideoCount => widget.module.videos
      .where((v) => !v.comingSoon && v.videoId.isNotEmpty)
      .length;

  Widget _buildPlaceholder(VideoModule video) {
    return Container(
      width: double.infinity,
      height: 220,
      color: DesaCColors.accentBlue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              video.comingSoon
                  ? Icons.lock_outline_rounded
                  : Icons.hourglass_empty_rounded,
              color: Colors.white30,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              video.comingSoon ? 'Video Segera Hadir' : 'Video Tidak Tersedia',
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoInfo(VideoModule video, Color accentColor) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 36,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  video.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: DesaCColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.module.description,
            style: const TextStyle(
              fontSize: 12,
              color: DesaCColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: _downloadPdf,
          icon: const Icon(Icons.download_rounded, size: 18),
          label: const Text(
            'Download Materi PDF',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: DesaCColors.accentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(Color accentColor) {
    final total = _availableVideoCount;
    final done = _watchedIndices.length;
    final progress = total == 0 ? 0.0 : done / total;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DesaCColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress Modul ${widget.module.num}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: DesaCColors.textPrimary,
                ),
              ),
              Text(
                '$done/$total video',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: accentColor.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistLabel(Color accentColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.playlist_play_rounded, size: 18, color: accentColor),
          const SizedBox(width: 6),
          Text(
            'PLAYLIST (${widget.module.videos.length} Video)',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: accentColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylist(Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: widget.module.videos.asMap().entries.map((e) {
          final index = e.key;
          final video = e.value;
          return _buildPlaylistItem(index, video, accentColor);
        }).toList(),
      ),
    );
  }

  Widget _buildPlaylistItem(int index, VideoModule video, Color accentColor) {
    final isSelected = index == _currentVideoIndex;
    final isDisabled = video.comingSoon || video.videoId.isEmpty;
    final isWatched = _watchedIndices.contains(index);

    return GestureDetector(
      onTap: isDisabled ? null : () => _switchVideo(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? accentColor.withValues(alpha: 0.4)
                : DesaCColors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              child: SizedBox(
                width: 100,
                height: 58,
                child: isDisabled || video.videoId.isEmpty
                    ? Container(
                        color: DesaCColors.accentBlue.withValues(alpha: 0.07),
                        child: Icon(
                          Icons.lock_rounded,
                          color: DesaCColors.accentBlue.withValues(alpha: 0.3),
                          size: 20,
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            video.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: accentColor.withValues(alpha: 0.1),
                              child: Icon(
                                Icons.play_circle_outline,
                                color: accentColor.withValues(alpha: 0.4),
                                size: 22,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              color: accentColor.withValues(alpha: 0.3),
                              child: const Center(
                                child: Icon(
                                  Icons.play_circle_filled_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          if (isWatched && !isSelected)
                            Container(
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDisabled
                            ? DesaCColors.textSecondary
                            : (isSelected
                                  ? accentColor
                                  : DesaCColors.textPrimary),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? DesaCColors.textSecondary
                                : accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (isWatched)
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                size: 11,
                                color: DesaCColors.accentGreen,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Selesai',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: DesaCColors.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        else if (isDisabled)
                          Text(
                            'Segera Hadir',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else if (isSelected)
                          Row(
                            children: [
                              Icon(
                                Icons.play_circle_rounded,
                                size: 11,
                                color: accentColor,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'Sedang Diputar',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            'Belum ditonton',
                            style: TextStyle(
                              fontSize: 10,
                              color: DesaCColors.textSecondary.withValues(alpha: 0.7),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                isDisabled
                    ? Icons.lock_outline_rounded
                    : (isSelected
                          ? Icons.pause_circle_rounded
                          : Icons.play_circle_outline_rounded),
                color: isDisabled
                    ? Colors.orange.withValues(alpha: 0.5)
                    : (isSelected
                          ? accentColor
                          : DesaCColors.textSecondary.withValues(alpha: 0.4)),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
