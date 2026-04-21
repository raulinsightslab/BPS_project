// lib/screens/quiz_screen.dart
import 'package:bps_e_learning/views/desa_cantik/screen/kuis/kuis_data.dart';
import 'package:flutter/material.dart';
import 'score_screen.dart';

class QuizScreen extends StatefulWidget {
  final Module module;

  const QuizScreen({Key? key, required this.module}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<String?> _answers;
  late List<bool> _answered;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _answers = List<String?>.filled(widget.module.questions.length, null);
    _answered = List<bool>.filled(widget.module.questions.length, false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(String answer) {
    setState(() {
      _answers[_currentIndex] = answer;
      _answered[_currentIndex] = true;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.module.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showFinishDialog();
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Selesai?'),
        content: const Text('Apakah Anda yakin ingin menyelesaikan kuis ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kembali'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _calculateScore();
            },
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  void _calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.module.questions.length; i++) {
      if (_answers[i] == widget.module.questions[i].correctAnswer) {
        score++;
      }
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScoreScreen(
          module: widget.module,
          score: score,
          totalQuestions: widget.module.questions.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar Kuis?'),
            content: const Text(
              'Jawaban Anda tidak akan disimpan. Yakin ingin keluar?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Ya, Keluar'),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9500),
          title: Text(
            'Modul ${widget.module.id}: ${widget.module.title}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Keluar Kuis?'),
                  content: const Text(
                    'Jawaban Anda tidak akan disimpan. Yakin ingin keluar?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tidak'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Ya, Keluar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: Column(
          children: [
            // Progress Bar Section
            _buildProgressBar(),
            // Questions Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: widget.module.questions.length,
                itemBuilder: (context, index) {
                  final question = widget.module.questions[index];
                  return _buildQuestionCard(question, index);
                },
              ),
            ),
            // Navigation Buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFFF9500).withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Soal ${_currentIndex + 1} dari ${widget.module.questions.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${((_currentIndex + 1) / widget.module.questions.length * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF9500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (_currentIndex + 1) / widget.module.questions.length,
              minHeight: 8,
              backgroundColor: const Color(0xFFFF9500).withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFF9500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          // Previous Button
          Expanded(
            child: ElevatedButton(
              onPressed: _currentIndex > 0 ? _previousQuestion : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.grey[300],
                disabledBackgroundColor: Colors.grey[200],
                disabledForegroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Sebelumnya',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Next Button
          Expanded(
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: const Color(0xFFFF9500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
              ),
              child: Text(
                _currentIndex == widget.module.questions.length - 1
                    ? 'Selesai'
                    : 'Selanjutnya',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(Question question, int index) {
    final options = ['A', 'B', 'C', 'D'];
    final isAnswered = _answered[index];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFFF9500).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Text(
              question.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Options Label
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Pilih jawaban yang benar:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.3,
              ),
            ),
          ),
          // Options List
          ...List.generate(question.options.length, (optionIndex) {
            final option = question.options[optionIndex];
            final optionLabel = options[optionIndex];
            final isSelected = _answers[index] == optionLabel;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildOptionButton(
                optionLabel: optionLabel,
                optionText: option,
                isSelected: isSelected,
                onTap: () => _selectAnswer(optionLabel),
              ),
            );
          }),
          const SizedBox(height: 24),
          // Answer Status
          _buildAnswerStatus(isAnswered, index),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required String optionLabel,
    required String optionText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF9500).withOpacity(0.15)
              : Colors.grey[50],
          border: Border.all(
            color: isSelected ? const Color(0xFFFF9500) : Colors.grey[300]!,
            width: isSelected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFFF9500).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Option Label Circle
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF9500) : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  optionLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Option Text
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isSelected ? const Color(0xFFFF9500) : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFFFF9500),
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerStatus(bool isAnswered, int index) {
    if (isAnswered) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(0.4), width: 1.5),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Jawaban tersimpan: ${_answers[index]}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange.withOpacity(0.4), width: 1.5),
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.orange, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Silakan pilih jawaban untuk melanjutkan',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
