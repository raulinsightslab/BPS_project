// lib/features/quiz/quiz_result_screen.dart
import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/models/quiz_module_model.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizModuleModel module;
  final int score;
  final int correctCount;
  final int totalQuestion;
  final String program;

  const QuizResultScreen({
    super.key,
    required this.module,
    required this.score,
    required this.correctCount,
    required this.totalQuestion,
    required this.program,
    required bool isDesaCantik,
  });

  String _getScoreMessage() {
    if (score >= 90) return 'Luar Biasa! 🎉';
    if (score >= 70) return 'Bagus! 👏';
    if (score >= 50) return 'Terus Belajar! 💪';
    return 'Jangan Menyerah! 📚';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuizColors.bg,
      appBar: AppBar(
        backgroundColor: QuizColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hasil Kuis',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trophy Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: QuizColors.orange.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: QuizColors.orange,
                  size: 60,
                ),
              ),
              const SizedBox(height: 24),

              // Score
              Text(
                '$score%',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: QuizColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getScoreMessage(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: score >= 70 ? QuizColors.success : QuizColors.orange,
                ),
              ),
              const SizedBox(height: 24),

              // Module info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: QuizColors.cardBorder, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: QuizColors.primary.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          'Benar',
                          '$correctCount',
                          QuizColors.success,
                        ),
                        _buildStatItem(
                          'Salah',
                          '${totalQuestion - correctCount}',
                          Colors.red.shade400,
                        ),
                        _buildStatItem(
                          'Total',
                          '$totalQuestion',
                          QuizColors.primary,
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: QuizColors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Modul ${module.num}: ${module.title}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: QuizColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: QuizColors.primary.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          color: QuizColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: QuizColors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Ke Dashboard',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
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

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: QuizColors.textSecondary),
        ),
      ],
    );
  }
}
