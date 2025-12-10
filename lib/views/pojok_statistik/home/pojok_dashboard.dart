import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFF0A2A6B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Pojok Statistik",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Modul Pembelajaran",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // POSTER
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/potik_ilustrasi.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔥 LIST VIDEO (REAL DATA)
                  buildVideoCard(
                    title:
                        "Sinergi Data BPS dan Google Scholar : Strategi Peneliti Cerdas",
                    desc:
                        "Cara cerdas memanfaatkan Google Scholar dan data BPS untuk penelitian yang efektif.",
                    url: "https://www.youtube.com/watch?v=wAZHwiDd1F4&t=3s",
                  ),
                  buildVideoCard(
                    title:
                        "Analisis Bibliometrik untuk Penelitian Ilmiah (VOSviewer & Bibliometrix)",
                    desc:
                        "Panduan analisis bibliometrik menggunakan VOSviewer dan R Bibliometrix.",
                    url: "https://youtu.be/PpYQjQ2jjwo",
                  ),
                  buildVideoCard(
                    title:
                        "Prospek Deep Learning Model untuk Analisis Citra Medis",
                    desc:
                        "Pembahasan perkembangan model deep learning untuk mendukung analisis citra medis.",
                    url: "https://www.youtube.com/watch?v=3JdKTOE3-Uw&t=1s",
                  ),
                  buildVideoCard(
                    title:
                        "Perkembangan Model Generalized STAR: Menembus Ruang & Waktu",
                    desc:
                        "Pengenalan model Generalized STAR serta pemanfaatannya dalam analisis spasial-temporal.",
                    url: "https://youtu.be/u7c5ERJ1SKw",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // 🔥 VIDEO CARD — Ganti dari module card, tapi fitur & style tetap sama
  // =======================================================================
  Widget buildVideoCard({
    required String title,
    required String desc,
    required String url,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A2A6B),
            ),
          ),

          const SizedBox(height: 6),

          // DESKRIPSI
          Text(
            desc,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),

          const SizedBox(height: 16),

          // BUTTON — open YouTube
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF29F05),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => launchUrl(
                Uri.parse(url),
                mode: LaunchMode.externalApplication,
              ),
              child: const Text(
                "Tonton Video  ▶",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
