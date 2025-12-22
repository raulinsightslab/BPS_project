import 'package:flutter/material.dart';
import 'package:bps_e_learning/model/modul_model.dart';
import 'package:bps_e_learning/model/video_item.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/video_page.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int? _selectedModule;

  final List<ModuleModel> modules = [
    // 1
    ModuleModel(
      title: "1. Penjelasan Umum Desa Cantik",
      lessons: [
        LessonModel(
          title: "Penjelasan Umum Desa Cantik",
          description:
              "Penjelasan mengenai konsep program Desa Cantik dan tujuan utamanya.",
          pdfUrl:
              "https://drive.google.com/file/d/1DdKY8LN4TOE3zGIzlqVZQeRXhUeLmr2g/view",
          videos: [
            VideoItem(
              title: "Penjelasan Umum Desa Cantik",
              videoId: "cihJ34cCzNU",
            ),
          ],
        ),
      ],
    ),

    // 2
    ModuleModel(
      title: "2. Penyelenggaraan Kegiatan Statistik",
      lessons: [
        LessonModel(
          title: "Penyelenggaraan Kegiatan Statistik",
          description: "Materi penyelenggaraan kegiatan statistik.",
          pdfUrl:
              "https://drive.google.com/file/d/1sZR5Ab7oh9aqEDR7yFgChF6h6h1hSFO-/view",
          videos: [
            VideoItem(
              title: "Materi Penyelenggaraan Kegiatan Statistik",
              videoId: "",
              comingSoon: true,
            ),
          ],
        ),
      ],
    ),

    // 3
    ModuleModel(
      title: "3. Pengumpulan Data",
      lessons: [
        LessonModel(
          title: "Pengumpulan Data",
          description: "Materi terkait proses pengumpulan data Desa Cantik.",
          pdfUrl:
              "https://drive.google.com/file/d/1Oawu2LF0jKahSZ2A00lzHVZ2giBJ_cwy/view",
          videos: [
            VideoItem(title: "Cara Pengumpulan Data", videoId: "5Easdr98usA"),
            VideoItem(title: "Teknik Pengumpulan Data", videoId: "fPsu3H_ECrw"),
            VideoItem(
              title: "Penyusunan Instrumen Pengumpulan Data",
              videoId: "Zb9zCQIxGQk",
            ),
            VideoItem(
              title: "Pengumpulan Data pada Program Desa Cantik",
              videoId: "jVNib4ISlo0",
            ),
          ],
        ),
      ],
    ),

    // 4
    ModuleModel(
      title: "4. Pengolahan Data",
      lessons: [
        LessonModel(
          title: "Pengolahan Data",
          description: "Materi pengolahan data statistik desa.",
          pdfUrl:
              "https://drive.google.com/file/d/1e0xj4EZZRAwgBOeV00dgTKNKebAl6BwC/view",
          videos: [
            VideoItem(title: "Moda Pengumpulan Data", videoId: "O44h5hBIRnI"),
            VideoItem(title: "Tahapan Pengolahan Data", videoId: "lwDgYzat0l4"),
            VideoItem(title: "Validasi Data", videoId: "lLxMLUZexp4"),
          ],
        ),
      ],
    ),

    // 5
    ModuleModel(
      title: "5. Analisis Data",
      lessons: [
        LessonModel(
          title: "Analisis Data",
          description: "Materi analisis data desa.",
          pdfUrl:
              "https://drive.google.com/file/d/1JMVEA9VbLGKfJonX27Ply-M0HcEwf667/view",
          videos: [
            VideoItem(title: "Tentang Analisis Data", videoId: "TeN_U4ardN4"),
            VideoItem(
              title: "Teknik Analisis Deskriptif",
              videoId: "Fz-NcR9VgbA",
            ),
            VideoItem(
              title: "Penyajian dan Visualisasi Data",
              videoId: "qF3cji6RUWM",
            ),
          ],
        ),
      ],
    ),

    // 6
    ModuleModel(
      title: "6. Penyajian Data",
      lessons: [
        LessonModel(
          title: "Penyajian Data",
          description: "Materi penyajian data statistik desa.",
          pdfUrl:
              "https://drive.google.com/file/d/1_R4weDyri1xC--vwwfvntC6yOJj0pnl0/view",
          videos: [
            VideoItem(title: "Penyajian Tabel", videoId: "gRAdwI11K6U"),
            VideoItem(title: "Penyajian Grafik", videoId: "Kl355bUGWV0"),
            VideoItem(title: "Penyajian Infografis", videoId: "n4Mx6nS2w84"),
            VideoItem(title: "Penyebarluasan Data", videoId: "Q6hWgYMRlSY"),
          ],
        ),
      ],
    ),

    // 7
    ModuleModel(
      title: "7. Manajemen Kualitas Data",
      lessons: [
        LessonModel(
          title: "Manajemen Kualitas Data",
          description: "Materi manajemen kualitas data.",
          pdfUrl:
              "https://drive.google.com/file/d/1mNH_utsyxorDVQX6NjohgLXy-XqbyY9B/view",
          videos: [
            VideoItem(
              title: "Manajemen Kualitas Data",
              videoId: "",
              comingSoon: true,
            ),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Modul Pembelajaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   "Daftar Modul Pembinaan Desa Cantik",
                  //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  // ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildModuleCard(index),
                childCount: modules.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(int index) {
    final module = modules[index];
    final isOpen = _selectedModule == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isOpen ? const Color(0xFFFF8A00) : Colors.black12,
          width: 1.8,
        ),
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
              Row(
                children: [
                  const Icon(Icons.menu_book_rounded, color: Colors.orange),
                  const SizedBox(width: 12),
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
                    color: Colors.orange,
                  ),
                ],
              ),
              if (isOpen) ...[
                const SizedBox(height: 14),
                const Divider(),
                ...module.lessons.map((lesson) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.play_circle_fill_rounded,
                      color: Color(0xFFFF8A00),
                    ),
                    title: Text(lesson.title),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VideoPage(lesson: lesson),
                        ),
                      );
                    },
                  );
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
