// file: lib/views/desa_cantik/screen/tugas_screen.dart
import 'package:flutter/material.dart';

/// SAMPLE local file path from conversation history (will be transformed by your tooling)
/// Developer note: keep this exact local path; tooling will convert it into a downloadable URL.
const String sampleFilePath =
    '/mnt/data/e80033a1-569c-4520-86ee-31bc7f50f39d.png';

/// Simple model for quiz question
class TaskQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? hint; // optional hint or resource link

  TaskQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.hint,
  });
}

/// DesaTugasPage: list of modules + start task button per module
class DesaTugasPage extends StatelessWidget {
  const DesaTugasPage({super.key});

  // Module titles (same order as di LearningPage)
  static const List<String> moduleTitles = [
    "Penjelasan Umum Desa Cantik",
    "Tata Kelola dan Skema Pembinaan",
    "Metadata Statistik",
    "Identifikasi Kebutuhan Desa",
    "Pengumpulan Data",
    "Pengolahan Data",
    "Analisis Deskriptif",
    "Tata Kelola Data dalam Sistem Informasi",
    "Penyajian Data",
    "Manajemen Kualitas Data",
    "Monitoring dan Evaluasi (Monev)",
    "Penilaian Desa Cantik",
  ];

  // Example: one question per module (you can expand later)
  static final List<List<TaskQuestion>> tugasPerModul = [
    // Modul 1
    [
      TaskQuestion(
        question: "Apa tujuan utama dari program Desa Cantik?",
        options: [
          "Meningkatkan kapasitas statistik desa",
          "Mengurangi angka kemiskinan secara langsung",
          "Membangun fasilitas umum baru",
          "Meningkatkan ekspor komoditas desa",
        ],
        correctIndex: 0,
        hint:
            "Baca ringkasan modul: tujuan program adalah memperkuat data dan kapasitas statistik desa.",
      ),
    ],

    // Modul 2
    [
      TaskQuestion(
        question: "Apa yang dimaksud dengan skema pembinaan Desa Cantik?",
        options: [
          "Proses pengorganisasian dan mentoring antar level pemerintahan",
          "Pembayaran insentif untuk kepala desa",
          "Penetapan pajak baru",
          "Pembangunan infrastruktur fisik",
        ],
        correctIndex: 0,
        hint: "Fokus: tata kelola = struktur & mekanisme pembinaan.",
      ),
    ],

    // Modul 3
    [
      TaskQuestion(
        question: "Metadata statistik biasanya berisi ...",
        options: [
          "Deskripsi sumber, cara pengumpulan, definisi variabel",
          "Harga barang di pasar lokal",
          "Data cuaca harian",
          "Peta jalan desa",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 4
    [
      TaskQuestion(
        question: "Langkah pertama identifikasi kebutuhan desa adalah ...",
        options: [
          "Pengumpulan data primer dan diskusi pemangku kepentingan",
          "Langsung membuat laporan tahunan",
          "Membangun website desa",
          "Mengajukan proposal ke donor",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 5
    [
      TaskQuestion(
        question:
            "Metode pengumpulan data yang cocok untuk sensus desa adalah ...",
        options: [
          "Pendataan door-to-door (kunjungan rumah)",
          "Analisis citra satelit saja",
          "Estimasi tanpa survei",
          "Polling via media sosial saja",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 6
    [
      TaskQuestion(
        question: "Tahap awal pengolahan data yang benar adalah ...",
        options: [
          "Validasi dan pembersihan data (cleaning)",
          "Langsung mempublikasikan data",
          "Menghapus semua missing value tanpa catatan",
          "Menyebarkan data ke publik",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 7
    [
      TaskQuestion(
        question: "Analisis deskriptif umumnya menghasilkan ...",
        options: [
          "Ringkasan statistik seperti mean, median, frekuensi",
          "Perangkat lunak baru",
          "Rancangan arsitektur rumah",
          "Prediksi cuaca",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 8
    [
      TaskQuestion(
        question:
            "Salah satu prinsip tata kelola data dalam sistem informasi adalah ...",
        options: [
          "Keamanan, akses terbatas, dokumentasi metadata",
          "Semua orang boleh ubah data tanpa jejak",
          "Simpan data hanya dalam file excel di laptop",
          "Hapus data lama tanpa backup",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 9
    [
      TaskQuestion(
        question: "Penyajian data yang efektif harus memenuhi aspek ...",
        options: [
          "Kejelasan, relevansi, dan visualisasi yang sesuai",
          "Hanya menampilkan angka tanpa konteks",
          "Memakai warna sebanyak-banyaknya",
          "Menggunakan tabel panjang tanpa ringkasan",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 10
    [
      TaskQuestion(
        question: "Salah satu metode menjaga kualitas data adalah ...",
        options: [
          "Melakukan validasi dan audit data secara berkala",
          "Mentransfer data antar file tanpa pemeriksaan",
          "Menggabungkan seluruh kolom jadi satu string",
          "Menghapus seluruh data tahun lalu",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 11
    [
      TaskQuestion(
        question: "Tahap monev yang penting dilakukan adalah ...",
        options: [
          "Menentukan indikator, mengumpulkan bukti, evaluasi hasil",
          "Membuat proyek baru tanpa evaluasi",
          "Menghapus indikator yang tidak disukai",
          "Mengevaluasi tanpa data",
        ],
        correctIndex: 0,
      ),
    ],

    // Modul 12
    [
      TaskQuestion(
        question: "Penilaian Desa Cantik dilakukan berdasarkan ...",
        options: [
          "Kriteria indikator yang telah ditetapkan dan bukti pendukung",
          "Suasana hati penilai",
          "Urutan pendaftaran desa saja",
          "Jumlah penduduk semata",
        ],
        correctIndex: 0,
      ),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDF9),
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: const Text(
          "Tugas & Kuis",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.orange.withOpacity(0.3),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tugas Pembelajaran",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Selesaikan tugas untuk setiap modul dan ukur pemahaman Anda",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),

            // Modules List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: moduleTitles.length,
                itemBuilder: (context, idx) {
                  final title = moduleTitles[idx];
                  final questions = tugasPerModul[idx];
                  return _buildModuleTaskCard(context, idx, title, questions);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleTaskCard(
    BuildContext context,
    int moduleIndex,
    String title,
    List<TaskQuestion> questions,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Start quiz for this module
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizPage(
                  moduleIndex: moduleIndex,
                  moduleTitle: title,
                  questions: questions,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.assignment,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${questions.length} soal",
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(
                                moduleIndex: moduleIndex,
                                moduleTitle: title,
                                questions: questions,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                        label: const Text(
                          "Mulai Tugas",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          _showResourceDialog(context);
                        },
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        tooltip: "Bantuan",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showResourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Materi Pembelajaran",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "File materi pembelajaran akan tersedia untuk diunduh setelah Anda menyelesaikan video modul terkait.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Contoh File:",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sampleFilePath,
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

/// QuizPage: tampilkan serangkaian pertanyaan, satu per view; hitung skor; tunjukkan hasil.
class QuizPage extends StatefulWidget {
  final int moduleIndex;
  final String moduleTitle;
  final List<TaskQuestion> questions;

  const QuizPage({
    super.key,
    required this.moduleIndex,
    required this.moduleTitle,
    required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQ = 0;
  int _score = 0;
  int? _selectedOption;
  bool _showAnswer = false;

  void _selectOption(int idx) {
    if (_selectedOption != null) return;
    setState(() => _selectedOption = idx);
    final correct = widget.questions[_currentQ].correctIndex;
    if (idx == correct) {
      _score++;
    }
    setState(() => _showAnswer = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() => _showAnswer = false);
    });
  }

  void _nextQuestion() {
    if (_selectedOption == null) return;
    if (_currentQ < widget.questions.length - 1) {
      setState(() {
        _currentQ++;
        _selectedOption = null;
        _showAnswer = false;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    double percentage = (_score / widget.questions.length) * 100;
    String resultText = percentage >= 70 ? "Selamat! 🎉" : "Coba Lagi! 📚";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(resultText),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modul: ${widget.moduleTitle}",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text("Skor: $_score/${widget.questions.length}"),
            Text("Persentase: ${percentage.toStringAsFixed(1)}%"),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade300,
              color: percentage >= 70 ? Colors.green : Colors.orange,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Kembali ke Daftar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentQ = 0;
                _score = 0;
                _selectedOption = null;
                _showAnswer = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text("Ulangi Kuis"),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[_currentQ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: Text(
          "Tugas - ${widget.moduleTitle}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Soal ${_currentQ + 1} dari ${widget.questions.length}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Skor: $_score",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (0.0 + _currentQ + 1) / widget.questions.length,
                      backgroundColor: Colors.orange.shade100,
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Question card
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pertanyaan:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              q.question,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Options
                      ...List.generate(q.options.length, (i) {
                        final option = q.options[i];
                        final isSelected = _selectedOption == i;
                        final isCorrect = q.correctIndex == i;

                        Color borderColor = Colors.grey.shade300;
                        Color bgColor = Colors.white;
                        Color textColor = Colors.black87;

                        if (_selectedOption != null) {
                          if (isCorrect) {
                            borderColor = Colors.green;
                            bgColor = Colors.green.withOpacity(0.1);
                          } else if (isSelected && !isCorrect) {
                            borderColor = Colors.red;
                            bgColor = Colors.red.withOpacity(0.1);
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => _selectOption(i),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.orange
                                            : Colors.grey.shade200,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + i),
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black87,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: textColor,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (_selectedOption != null && isCorrect)
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                    if (isSelected && !isCorrect)
                                      Icon(Icons.cancel, color: Colors.red),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      if (q.hint != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Tip: ${q.hint!}",
                                  style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedOption == null ? null : _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    _currentQ < widget.questions.length - 1
                        ? "Lanjut ke Soal Berikutnya"
                        : "Selesaikan Kuis",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
