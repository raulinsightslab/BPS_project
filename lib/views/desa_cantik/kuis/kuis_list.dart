// lib/screens/module_list_screen.dart
import 'package:bps_e_learning/views/desa_cantik/kuis/kuis_data.dart';
import 'package:bps_e_learning/views/desa_cantik/kuis/kuis_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/learning_descan.dart';

import 'package:flutter/material.dart';

class ModuleListScreen extends StatelessWidget {
  const ModuleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FIX #1: Ambil bottom padding untuk hindari konten tertutup navbar
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      // FIX #4: backgroundColor bg color supaya lengkungan header kelihatan
      backgroundColor: DesaCColors.bg,
      body: CustomScrollView(
        slivers: [
          // FIX #7: Pakai shared header widget yang sama dengan screen lain
          const DesaCantikSliverAppBar(
            title: 'Desa Cantik Quiz',
            subtitle: '7 Modul • 15 Soal Per Modul',
            badgeText: '7 Modul',
          ),
          // FIX #3: Kurangi top padding agar tidak ada gap besar
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 32 + bottomPadding + 60),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final module = quizModules[index];
                return _buildModuleCard(context, module);
              }, childCount: quizModules.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, Module module) {
    final colors = [
      const Color(0xFFFF9500),
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFF45B7D1),
      const Color(0xFF96CEB4),
      const Color(0xFFDDA15E),
      const Color(0xFFC9ADA7),
    ];

    final cardColor = colors[module.id - 1];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuizScreen(module: module)),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cardColor, cardColor.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: cardColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Module Number Circle
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'M${module.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Module Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        module.description,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.quiz, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            '${module.questions.length} soal',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
