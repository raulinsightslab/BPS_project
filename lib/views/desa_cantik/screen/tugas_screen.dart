import 'package:flutter/material.dart';

class DesaTugasPage extends StatelessWidget {
  const DesaTugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tugas Desa",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange.shade900,
                ),
              ),
              const SizedBox(height: 20),

              _taskTile("Mengisi Form Potensi Desa", false),
              _taskTile("Upload Foto Kegiatan Pelatihan", true),
              _taskTile("Pengumpulan Data SDGs Desa", false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskTile(String title, bool done) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: done ? Colors.green.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.orange.shade200, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.circle_outlined,
            color: done ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
