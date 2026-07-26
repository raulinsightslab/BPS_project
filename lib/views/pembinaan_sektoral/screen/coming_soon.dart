// lib/features/pembinaan_sektoral/dashboard/dashboard_pembinaan_screen.dart
import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/utils/app_colors.dart';

class DashboardPembinaanScreen extends StatelessWidget {
  const DashboardPembinaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pembinaanBg,
      body: SafeArea(
        child: Column(
          children: [
            _HeaderPembinaan(),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ComingSoonCard(),
                    const SizedBox(height: 24),
                    _FeaturePreviewSection(),
                    const SizedBox(height: 24),
                    _StatisticsInfoCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header Pembinaan Sektoral ──────────────────────────────────────────────
class _HeaderPembinaan extends StatelessWidget {
  const _HeaderPembinaan();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.pembinaanNavy, AppColors.pembinaanBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo row with exit button
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
                  'PS',
                  style: TextStyle(
                    color: AppColors.pembinaanNavy,
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
                    'Pembinaan Sektoral',
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
              // Exit button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Headline
          const Text(
            'Statistik Sektoral',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pembinaan dan Pengembangan Statistik Sektoral',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          // Stats row
          Row(
            children: [
              _StatChipPembinaan(
                icon: Icons.analytics_outlined,
                label: 'Statistik',
                color: AppColors.authOrange,
              ),
              const SizedBox(width: 10),
              _StatChipPembinaan(
                icon: Icons.school_outlined,
                label: 'Pembinaan',
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              _StatChipPembinaan(
                icon: Icons.trending_up_outlined,
                label: 'Sektoral',
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatChipPembinaan extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChipPembinaan({
    required this.icon,
    required this.label,
    required this.color,
  });

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
          Icon(icon, color: color, size: 13),
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

// ─── Coming Soon Card ──────────────────────────────────────────────────────
class _ComingSoonCard extends StatelessWidget {
  const _ComingSoonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.authOrange.withValues(alpha: 0.15),
            AppColors.pembinaanNavy.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.authOrange.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pembinaanNavy.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.authOrange, AppColors.desaOrangeDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.authOrange.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.construction_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Fitur Segera Hadir',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.pembinaanNavy,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kami sedang mengembangkan materi\npembinaan statistik sektoral untuk Anda',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Notification button
          Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.authOrange, AppColors.desaOrangeDark],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.authOrange.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Beritahu Saya Saat Tersedia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Feature Preview Section ──────────────────────────────────────────────
class _FeaturePreviewSection extends StatelessWidget {
  const _FeaturePreviewSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.authOrange,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'FITUR YANG AKAN DATANG',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.pembinaanNavy,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.video_library_rounded,
                title: 'Video Materi',
                description: 'Pembelajaran interaktif',
                color: AppColors.authOrange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FeatureCard(
                icon: Icons.assessment_rounded,
                title: 'Modul Statistik',
                description: 'Materi terstruktur',
                color: AppColors.pembinaanBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _FeatureCard(
                icon: Icons.quiz_rounded,
                title: 'Latihan Soal',
                description: 'Evaluasi pemahaman',
                color: AppColors.pembinaanNavy,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FeatureCard(
                icon: Icons.verified_rounded,
                title: 'Sertifikat',
                description: 'Pengakuan kompetensi',
                color: const Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.pojokCardBorder, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.pembinaanNavy.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.pembinaanNavy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

// ─── Statistics Info Card ──────────────────────────────────────────────────
class _StatisticsInfoCard extends StatelessWidget {
  const _StatisticsInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.pembinaanNavy.withValues(alpha: 0.05),
            AppColors.authOrange.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pojokCardBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.pembinaanNavy,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Tentang Statistik Sektoral',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.pembinaanNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Statistik sektoral adalah statistik yang pemanfaatannya ditujukan untuk memenuhi kebutuhan instansi tertentu dalam rangka penyelenggaraan tugas-tugas pemerintahan dan pembangunan yang menjadi tugas pokok instansi yang bersangkutan.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoBadge(
                icon: Icons.check_circle_rounded,
                label: 'Pembinaan',
                color: AppColors.pembinaanBlue,
              ),
              const SizedBox(width: 8),
              _InfoBadge(
                icon: Icons.check_circle_rounded,
                label: 'Koordinasi',
                color: AppColors.authOrange,
              ),
              const SizedBox(width: 8),
              _InfoBadge(
                icon: Icons.check_circle_rounded,
                label: 'Pengawasan',
                color: AppColors.pembinaanNavy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
