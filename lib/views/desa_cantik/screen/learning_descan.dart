import 'package:bps_e_learning/views/desa_cantik/screen/video_list_descan.dart';
import 'package:flutter/material.dart';

// ─── Color Constants ───────────────────────────────────────────────────────────
class DesaCColors {
  static const Color primary = Color(0xFFF59E0B);
  static const Color primaryDark = Color(0xFFE65100);
  static const Color primaryLight = Color(0xFFFFF3E8);
  static const Color accentBlue = Color(0xFF0A2A6B);
  static const Color accentGreen = Color(0xFF1B8A4A);
  static const Color accentGreenLight = Color(0xFFE8F5EE);
  static const Color accentBlueLight = Color(0xFFE8EEF8);
  static const Color bg = Color(0xFFF4F6FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0A2A6B);
  static const Color textSecondary = Color(0xFF6B7A99);
  static const Color divider = Color(0xFFE8EDF5);
}

// ─── Shared AppBar Header Widget ──────────────────────────────────────────────
class DesaCantikSliverAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;

  const DesaCantikSliverAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 160,
      pinned: true,

      backgroundColor: DesaCColors.bg,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          // FIX #4: bg luar transparan sehingga lengkungan bawah kelihatan
          color: DesaCColors.bg,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [DesaCColors.primary, DesaCColors.primaryDark],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, topPadding + 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'DC',
                          style: TextStyle(
                            color: DesaCColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Desa Cantik',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'BPS Kabupaten Tangerang',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          badgeText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // FIX #3: Tidak pakai Spacer, langsung bottom content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────────
class VideoModule {
  final String title;
  final String videoId;
  final bool comingSoon;

  const VideoModule({
    required this.title,
    required this.videoId,
    this.comingSoon = false,
  });

  String get thumbnailUrl => videoId.isNotEmpty
      ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
      : '';
}

class ModuleItem {
  final int id;
  final String num;
  final String title;
  final String description;
  final String pdfUrl;
  final List<VideoModule> videos;
  final Color accentColor;

  const ModuleItem({
    required this.id,
    required this.num,
    required this.title,
    required this.description,
    required this.pdfUrl,
    required this.videos,
    required this.accentColor,
  });

  int get videoCount => videos.length;
  bool get hasAvailableVideo =>
      videos.any((v) => !v.comingSoon && v.videoId.isNotEmpty);
}

// ─── Module Data ───────────────────────────────────────────────────────────────
final List<ModuleItem> kModules = [
  ModuleItem(
    id: 1,
    num: '01',
    title: 'Penjelasan Umum Desa Cantik',
    description:
        'Memahami konsep program Desa Cantik dan tujuan utamanya dalam pembangunan statistik desa',
    pdfUrl:
        'https://drive.google.com/file/d/1DdKY8LN4TOE3zGIzlqVZQeRXhUeLmr2g/view',
    accentColor: DesaCColors.primary,
    videos: [
      VideoModule(title: 'Penjelasan Umum Desa Cantik', videoId: 'iuYm1CH4ALo'),
    ],
  ),
  ModuleItem(
    id: 2,
    num: '02',
    title: 'Penyelenggaraan Kegiatan Statistik',
    description:
        'Materi penyelenggaraan kegiatan statistik dan mekanisme pelaksanaannya',
    pdfUrl:
        'https://drive.google.com/file/d/1sZR5Ab7oh9aqEDR7yFgChF6h6h1hSFO-/view',
    accentColor: DesaCColors.accentBlue,
    videos: [
      VideoModule(
        title: 'Penyelenggaraan Kegiatan Statistik',
        videoId: '',
        comingSoon: true,
      ),
    ],
  ),
  ModuleItem(
    id: 3,
    num: '03',
    title: 'Pengumpulan Data',
    description:
        'Teknik dan metode pengumpulan data yang efektif dalam program Desa Cantik',
    pdfUrl:
        'https://drive.google.com/file/d/1Oawu2LF0jKahSZ2A00lzHVZ2giBJ_cwy/view',
    accentColor: DesaCColors.accentGreen,
    videos: [
      VideoModule(title: 'Cara Pengumpulan Data', videoId: '5Easdr98usA'),
      VideoModule(title: 'Teknik Pengumpulan Data', videoId: 'fPsu3H_ECrw'),
      VideoModule(
        title: 'Penyusunan Instrumen Pengumpulan Data',
        videoId: 'Zb9zCQIxGQk',
      ),
      VideoModule(
        title: 'Pengumpulan Data pada Program Desa Cantik',
        videoId: 'jVNib4ISlo0',
      ),
    ],
  ),
  ModuleItem(
    id: 4,
    num: '04',
    title: 'Pengolahan Data',
    description:
        'Proses pengolahan dan validasi data statistik secara sistematis',
    pdfUrl:
        'https://drive.google.com/file/d/1e0xj4EZZRAwgBOeV00dgTKNKebAl6BwC/view',
    accentColor: DesaCColors.accentBlue,
    videos: [
      VideoModule(title: 'Moda Pengumpulan Data', videoId: 'O44h5hBIRnI'),
      VideoModule(title: 'Tahapan Pengolahan Data', videoId: 'lwDgYzat0l4'),
      VideoModule(title: 'Validasi Data', videoId: 'lLxMLUZexp4'),
    ],
  ),
  ModuleItem(
    id: 5,
    num: '05',
    title: 'Analisis Data',
    description:
        'Teknik analisis data dan interpretasi hasil analisis statistik',
    pdfUrl:
        'https://drive.google.com/file/d/1JMVEA9VbLGKfJonX27Ply-M0HcEwf667/view',
    accentColor: DesaCColors.accentGreen,
    videos: [
      VideoModule(title: 'Tentang Analisis Data', videoId: 'TeN_U4ardN4'),
      VideoModule(title: 'Teknik Analisis Deskriptif', videoId: 'Fz-NcR9VgbA'),
      VideoModule(
        title: 'Penyajian dan Visualisasi Data',
        videoId: 'qF3cji6RUWM',
      ),
    ],
  ),
  ModuleItem(
    id: 6,
    num: '06',
    title: 'Penyajian Data',
    description:
        'Cara penyajian data dalam bentuk tabel, grafik, dan infografis menarik',
    pdfUrl:
        'https://drive.google.com/file/d/1_R4weDyri1xC--vwwfvntC6yOJj0pnl0/view',
    accentColor: DesaCColors.primary,
    videos: [
      VideoModule(title: 'Penyajian Tabel', videoId: 'gRAdwI11K6U'),
      VideoModule(title: 'Penyajian Grafik', videoId: 'Kl355bUGWV0'),
      VideoModule(title: 'Penyajian Infografis', videoId: 'n4Mx6nS2w84'),
      VideoModule(title: 'Penyebarluasan Data', videoId: 'Q6hWgYMRlSY'),
    ],
  ),
  ModuleItem(
    id: 7,
    num: '07',
    title: 'Manajemen Kualitas Data',
    description:
        'Strategi dan praktik terbaik dalam manajemen kualitas data statistik',
    pdfUrl:
        'https://drive.google.com/file/d/1mNH_utsyxorDVQX6NjohgLXy-XqbyY9B/view',
    accentColor: DesaCColors.accentBlue,
    videos: [
      VideoModule(
        title: 'Manajemen Kualitas Data',
        videoId: '',
        comingSoon: true,
      ),
    ],
  ),
];

// ─── Main Learning Screen ───────────────────────────────────────────────────────
class DesaCantikLearningScreen extends StatelessWidget {
  const DesaCantikLearningScreen({super.key});

  void _openVideo(BuildContext context, ModuleItem module, int videoIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DesaCantikVideoListScreen(
          module: module,
          initialVideoIndex: videoIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FIX #1: Ambil bottom padding untuk hindari konten tertutup navbar
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: DesaCColors.bg,
      body: CustomScrollView(
        slivers: [
          // FIX #7: Pakai shared header widget
          const DesaCantikSliverAppBar(
            title: 'Modul Pembelajaran',
            subtitle: 'Tingkatkan pengetahuan statistikmu bersama BPS',
            badgeText: '7 Modul',
          ),
          SliverToBoxAdapter(
            child: Padding(
              // FIX #3: Kurangi top padding agar tidak ada gap besar
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 18,
                    decoration: BoxDecoration(
                      color: DesaCColors.accentBlue,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.school_rounded,
                    size: 16,
                    color: DesaCColors.accentBlue,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'MODUL PEMBELAJARAN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: DesaCColors.accentBlue,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final module = kModules[index];
                return _ModuleSection(
                  module: module,
                  onVideoTap: (videoIndex) =>
                      _openVideo(context, module, videoIndex),
                );
              }, childCount: kModules.length),
            ),
          ),
          // FIX #1: Bottom padding agar konten terakhir tidak tertutup navbar
          SliverToBoxAdapter(child: SizedBox(height: 32 + bottomPadding + 60)),
        ],
      ),
    );
  }
}

// ─── Module Section ───────────────────────────────────────────────────────────
class _ModuleSection extends StatelessWidget {
  final ModuleItem module;
  final void Function(int) onVideoTap;

  const _ModuleSection({required this.module, required this.onVideoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: DesaCColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: DesaCColors.divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: module.accentColor.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: module.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    module.num,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: DesaCColors.textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        module.description,
                        style: const TextStyle(
                          fontSize: 11,
                          color: DesaCColors.textSecondary,
                          height: 1.4,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: module.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${module.videoCount} video',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: module.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Video tiles
          ...module.videos.asMap().entries.map((e) {
            final idx = e.key;
            final video = e.value;
            final isLast = idx == module.videos.length - 1;
            return _VideoThumbnailTile(
              video: video,
              index: idx,
              module: module,
              isLast: isLast,
              onTap: video.comingSoon ? null : () => onVideoTap(idx),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Video Thumbnail Tile ──────────────────────────────────────────────────────
class _VideoThumbnailTile extends StatelessWidget {
  final VideoModule video;
  final int index;
  final ModuleItem module;
  final bool isLast;
  final VoidCallback? onTap;

  const _VideoThumbnailTile({
    required this.video,
    required this.index,
    required this.module,
    required this.isLast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = video.comingSoon;

    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(16))
          : BorderRadius.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(color: DesaCColors.divider, width: 1),
                ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 120,
                height: 68,
                child: isDisabled || video.videoId.isEmpty
                    ? Container(
                        color: DesaCColors.accentBlue.withValues(alpha: 0.07),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock_rounded,
                                color: DesaCColors.accentBlue.withValues(
                                  alpha: 0.4,
                                ),
                                size: 22,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Segera\nHadir',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: DesaCColors.accentBlue.withValues(
                                    alpha: 0.5,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            video.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: DesaCColors.accentBlue.withValues(
                                alpha: 0.1,
                              ),
                              child: Icon(
                                Icons.play_circle_outline,
                                color: DesaCColors.accentBlue.withValues(
                                  alpha: 0.4,
                                ),
                                size: 28,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.55),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 20,
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDisabled
                          ? DesaCColors.textSecondary
                          : DesaCColors.textPrimary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: module.accentColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isDisabled ? 'Segera Hadir' : 'Modul ${module.num}',
                        style: TextStyle(
                          fontSize: 10,
                          color: isDisabled
                              ? Colors.orange
                              : DesaCColors.textSecondary,
                          fontWeight: isDisabled
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Icon(
              isDisabled
                  ? Icons.lock_outline_rounded
                  : Icons.chevron_right_rounded,
              color: isDisabled
                  ? Colors.orange.withValues(alpha: 0.6)
                  : DesaCColors.textSecondary.withValues(alpha: 0.5),
              size: isDisabled ? 16 : 20,
            ),
          ],
        ),
      ),
    );
  }
}
