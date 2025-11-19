import 'package:bps_e_learning/model/modul.dart';
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
      title: "Pengenalan Data Desa",
      lessons: [
        LessonModel(
          title: "Apa Itu Data Desa?",
          videoId: "2Vv-BfVoq4g",
          description: "Penjelasan dasar tentang data desa.",
          pdfUrl: "",
        ),
        LessonModel(
          title: "Jenis Data Penting",
          videoId: "3JZ_D3ELwOQ",
          description: "Kategori data yang digunakan dalam sistem desa.",
          pdfUrl: "",
        ),
      ],
    ),
    ModuleModel(
      title: "Pengolahan Data Desa",
      lessons: [
        LessonModel(
          title: "Cara Input Data",
          videoId: "dQw4w9WgXcQ",
          description:
              "Langkah-langkah lengkap menginput data desa melalui aplikasi.",
          pdfUrl: "",
        ),
        LessonModel(
          title: "Validasi Data",
          videoId: "L_jWHffIx5E",
          description:
              "Cara memastikan data desa valid dan siap digunakan analisis.",
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
        title: const Text(
          "Modul Pembelajaran",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF005BBB), // BPS Blue
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Daftar Modul",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF005BBB),
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
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 16),
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
                      color: Color(0xFF005BBB),
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

              // EXPANDED
              if (isOpen) ...[
                const SizedBox(height: 16),
                Divider(color: Colors.blue.shade100),
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
                        color: Colors.blue.shade50,
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
                          const Icon(Icons.chevron_right_rounded),
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
