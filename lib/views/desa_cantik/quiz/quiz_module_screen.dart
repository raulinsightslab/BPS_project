// lib/features/quiz/quiz_module_screen.dart
import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/views/desa_cantik/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/models/quiz_module_model.dart';
import 'package:bps_e_learning/core/services/quiz_firestore_service.dart';

class QuizModuleScreen extends StatefulWidget {
  final String program;
  final bool isDesaCantik;

  const QuizModuleScreen({
    super.key,
    required this.program,
    this.isDesaCantik = false,
  });

  @override
  State<QuizModuleScreen> createState() => _QuizModuleScreenState();
}

class _QuizModuleScreenState extends State<QuizModuleScreen> {
  final QuizFirestoreService _quizService = QuizFirestoreService();
  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      backgroundColor: AppColors.desaBg,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: AppColors.desaOrange,
        child: Column(
          children: [
            _Header(program: widget.program, isDesaCantik: widget.isDesaCantik),
            Expanded(
              child: FutureBuilder<List<QuizModuleModel>>(
                future: _quizService.getQuizModules(widget.program),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.desaOrange,
                      ),
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
                            'Gagal memuat kuis',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.desaBlue,
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
                              backgroundColor: AppColors.desaOrange,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  final modules = snapshot.data ?? [];

                  if (modules.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.quiz_rounded,
                            color: const Color(0xFFB0BEC5),
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Belum ada kuis tersedia',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.desaBlue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Program ${_getProgramDisplayName(widget.program)} belum memiliki materi kuis',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pastikan data di Firestore sudah diisi',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.desaOrange,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      _SectionLabel(
                        label: 'MODUL KUIS',
                        isDesaCantik: widget.isDesaCantik,
                      ),
                      const SizedBox(height: 4),
                      ...modules.asMap().entries.map(
                        (e) => _QuizModuleCard(
                          module: e.value,
                          index: e.key,
                          isDesaCantik: widget.isDesaCantik,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuizScreen(
                                  module: e.value,
                                  program: widget.program,
                                  isDesaCantik: widget.isDesaCantik,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final String program;
  final bool isDesaCantik;

  const _Header({required this.program, required this.isDesaCantik});

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

  Color get _primaryColor => AppColors.desaOrange;
  // Color get _primaryLightColor => AppColors.desaOrangeLight;
  String get _appTitle => 'Desa Cantik';
  String get _logoText => 'DC';
  Color get _logoBgColor => Colors.white;
  Color get _logoTextColor => AppColors.desaOrange;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorPs.desaPrimary, ColorPs.desaPrimaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                  color: _logoBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  _logoText,
                  style: TextStyle(
                    color: _logoTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _appTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'BPS Kabupaten Tangerang',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
          // Headline with dynamic program name
          const Text(
            'Kuis Pembelajaran',
            style: TextStyle(
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
          Row(
            children: [
              _StatChip(
                icon: Icons.quiz_rounded,
                label: 'Kuis',
                isDesaCantik: isDesaCantik,
              ),
              const SizedBox(width: 10),
              _StatChip(
                icon: Icons.access_time_rounded,
                label: 'Gratis',
                isDesaCantik: isDesaCantik,
              ),
              const SizedBox(width: 10),
              _StatChip(
                icon: Icons.verified_rounded,
                label: 'BPS Resmi',
                isDesaCantik: isDesaCantik,
              ),
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
  final bool isDesaCantik;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.isDesaCantik,
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
          Icon(icon, color: Colors.white, size: 13),
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
  final bool isDesaCantik;

  const _SectionLabel({required this.label, required this.isDesaCantik});

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
              color: AppColors.desaOrange,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.desaOrange,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quiz Module Card ─────────────────────────────────────────────────────────
class _QuizModuleCard extends StatelessWidget {
  final QuizModuleModel module;
  final int index;
  final bool isDesaCantik;
  final VoidCallback onTap;

  const _QuizModuleCard({
    required this.module,
    required this.index,
    required this.isDesaCantik,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.desaDivider, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.desaOrange.withValues(alpha: 0.07),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.desaOrange,
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
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.desaTextPrimary,
                            height: 1.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          module.description,
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.desaTextSecondary,
                            height: 1.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: AppColors.desaDivider),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.quiz_rounded,
                    color: AppColors.desaOrange,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${module.totalQuestion} Soal',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.desaTextSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.desaOrange,
                          AppColors.desaOrangeDark,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Mulai Kuis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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
}
