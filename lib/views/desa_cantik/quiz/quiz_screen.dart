// lib/features/quiz/quiz_screen.dart
import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/views/desa_cantik/quiz/quiz_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/models/quiz_module_model.dart';
import 'package:bps_e_learning/core/models/quiz_model.dart';
import 'package:bps_e_learning/core/services/quiz_firestore_service.dart';

class QuizScreen extends StatefulWidget {
  final QuizModuleModel module;
  final String program;
  final bool isDesaCantik;

  const QuizScreen({
    super.key,
    required this.module,
    required this.program,
    this.isDesaCantik = false,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizFirestoreService _quizService = QuizFirestoreService();
  final PageController _pageController = PageController();
  final Map<int, String> _selectedAnswers = {};
  int _currentIndex = 0;
  bool _isLoading = true;
  List<QuizModel> _questions = [];

  Color get _primaryColor =>
      widget.isDesaCantik ? QuizColors.desaPrimary : QuizColors.primary;

  Color get _bgColor => widget.isDesaCantik ? QuizColors.desaBg : QuizColors.bg;

  String get _appTitle =>
      widget.isDesaCantik ? 'Desa Cantik' : 'Pojok Statistik';

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await _quizService.getQuizQuestions(
        widget.module.moduleId,
      );
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat soal: $e')));
      }
    }
  }

  void _selectAnswer(String value) {
    setState(() {
      _selectedAnswers[_currentIndex] = value;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitQuiz();
    }
  }

  void _submitQuiz() {
    int correctCount = 0;
    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final selected = _selectedAnswers[i];
      if (selected == question.correctAnswer) {
        correctCount++;
      }
    }

    final totalQuestion = _questions.length;
    final score = (correctCount / totalQuestion * 100).round();

    // Save result
    _quizService.saveQuizResult(
      moduleId: widget.module.moduleId,
      program: widget.program,
      score: score,
      correctCount: correctCount,
      totalQuestion: totalQuestion,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          module: widget.module,
          score: score,
          correctCount: correctCount,
          totalQuestion: totalQuestion,
          program: widget.program,
          isDesaCantik: widget.isDesaCantik,
        ),
      ),
    );
  }

  bool get _isLastQuestion => _currentIndex == _questions.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
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
            padding: const EdgeInsets.only(right: 16),
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
                  '${_selectedAnswers.length}/${_questions.length}',
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: QuizColors.orange),
            )
          : _questions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.grey,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Belum ada soal untuk kuis ini',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: QuizColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: QuizColors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Kembali'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      final question = _questions[index];
                      return _QuestionPage(
                        question: question,
                        selectedAnswer: _selectedAnswers[index],
                        onSelect: _selectAnswer,
                        index: index,
                        total: _questions.length,
                        isDesaCantik: widget.isDesaCantik,
                      );
                    },
                  ),
                ),
                _buildBottomBar(),
              ],
            ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: _primaryColor.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Sebelumnya',
                  style: TextStyle(
                    color: _primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          if (_currentIndex > 0) const SizedBox(width: 12),
          Expanded(
            flex: _currentIndex == 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: _selectedAnswers[_currentIndex] == null
                  ? null
                  : _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: QuizColors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                disabledBackgroundColor: QuizColors.orange.withValues(
                  alpha: 0.5,
                ),
              ),
              child: Text(
                _isLastQuestion ? 'Selesai' : 'Selanjutnya',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Question Page ───────────────────────────────────────────────────────────
class _QuestionPage extends StatelessWidget {
  final QuizModel question;
  final String? selectedAnswer;
  final Function(String) onSelect;
  final int index;
  final int total;
  final bool isDesaCantik;

  const _QuestionPage({
    required this.question,
    required this.selectedAnswer,
    required this.onSelect,
    required this.index,
    required this.total,
    required this.isDesaCantik,
  });

  Color get _primaryColor =>
      isDesaCantik ? QuizColors.desaPrimary : QuizColors.primary;

  Color get _textPrimaryColor =>
      isDesaCantik ? QuizColors.desaTextPrimary : QuizColors.primary;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _primaryColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Soal ${index + 1} dari $total',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Question
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDesaCantik
                    ? QuizColors.desaDivider
                    : QuizColors.cardBorder,
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryColor.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _textPrimaryColor,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Options
          ...question.options.asMap().entries.map((entry) {
            final optionIndex = entry.key;
            final optionLetter = String.fromCharCode(65 + optionIndex);
            final optionValue = 'ABCD'[optionIndex];
            final isSelected = selectedAnswer == optionValue;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? QuizColors.orange.withValues(alpha: 0.08)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? QuizColors.orange
                      : (isDesaCantik
                            ? QuizColors.desaDivider
                            : QuizColors.cardBorder),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: QuizColors.orange.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: RadioListTile<String>(
                value: optionValue,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  if (value != null) onSelect(value);
                },
                title: Text(
                  '${optionLetter}. ${entry.value}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? _primaryColor : Colors.black87,
                  ),
                ),
                activeColor: QuizColors.orange,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
