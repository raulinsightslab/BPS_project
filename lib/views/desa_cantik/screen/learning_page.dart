import 'package:bps_e_learning/model/modul_model.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/video_page.dart';
import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int? _selectedModule;

  final List<ModuleModel> modules = [
    ModuleModel(
      title: "Penjelasan Umum Desa Cantik",
      lessons: [
        LessonModel(
          title: "Penjelasan Umum Desa Cantik",
          videoId: "cihJ34cCzNU",
          description:
              "Penjelasan mengenai konsep program Desa Cantik dan tujuan utamanya.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Tata Kelola dan Skema Pembinaan",
      lessons: [
        LessonModel(
          title: "Tata Kelola Desa Cantik",
          videoId: "cihJ34cCzNU",
          description:
              "Struktur tata kelola dan mekanisme pembinaan dalam program Desa Cantik.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Metadata Statistik",
      lessons: [
        LessonModel(
          title: "Metadata Statistik Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Penjelasan dasar tentang metadata statistik untuk desa.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Identifikasi Kebutuhan Desa",
      lessons: [
        LessonModel(
          title: "Cara Mengidentifikasi Kebutuhan Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Metode identifikasi kebutuhan desa untuk keperluan statistik dan pembangunan.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Pengumpulan Data",
      lessons: [
        LessonModel(
          title: "Teknik Pengumpulan Data",
          videoId: "cihJ34cCzNU",
          description:
              "Metode dan tata cara pengumpulan data desa secara benar.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Pengolahan Data",
      lessons: [
        LessonModel(
          title: "Pengolahan Data Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Proses pengolahan data desa menggunakan teknik statistik dasar.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Analisis Deskriptif",
      lessons: [
        LessonModel(
          title: "Analisis Deskriptif Data Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Cara melakukan analisis deskriptif untuk hasil data desa.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Tata Kelola Data dalam Sistem Informasi",
      lessons: [
        LessonModel(
          title: "Data Management pada Sistem Informasi Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Pengelolaan data desa dalam sistem informasi berbasis digital.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Penyajian Data",
      lessons: [
        LessonModel(
          title: "Penyajian Data Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Cara menyajikan data desa secara menarik dan mudah dipahami.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Manajemen Kualitas Data",
      lessons: [
        LessonModel(
          title: "Data Quality Management Desa",
          videoId: "cihJ34cCzNU",
          description:
              "Teknik menjaga kualitas data desa agar tetap valid dan terpercaya.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Monitoring dan Evaluasi (Monev)",
      lessons: [
        LessonModel(
          title: "Monev Program Desa Cantik",
          videoId: "cihJ34cCzNU",
          description:
              "Proses monitoring dan evaluasi pelaksanaan program Desa Cantik.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Penilaian Desa Cantik",
      lessons: [
        LessonModel(
          title: "Penilaian Desa Cantik",
          videoId: "cihJ34cCzNU",
          description:
              "Cara penilaian dan indikator keberhasilan dalam program Desa Cantik.",
          pdfUrl: "",
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: Text(
          "Modul Pembelajaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Daftar Modul Pembinaan Desa Cantik",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(modules.length, (index) => _buildModuleCard(index)),
        ],
      ),
    );
  }

  Widget _buildModuleCard(int index) {
    final module = modules[index];
    final isOpen = _selectedModule == index;

    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isOpen ? const Color(0xFFFF8A00) : Colors.black12,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          setState(() {
            _selectedModule = isOpen ? null : index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF005BBB).withOpacity(0.1),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      module.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    isOpen ? Icons.expand_less : Icons.expand_more,
                    size: 26,
                    color: const Color(0xFFFF8A00),
                  ),
                ],
              ),
              // EXPANDED CONTENT
              if (isOpen) ...[
                const SizedBox(height: 16),
                Divider(color: Colors.orange),
                const SizedBox(height: 14),
                ...module.lessons.map((lesson) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPage(lesson: lesson),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_circle_fill_rounded,
                            color: Color(0xFFFF8A00),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              lesson.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
