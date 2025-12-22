import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // ==========================
  // MENU ITEM BUILDER
  // ==========================
  Widget buildMenuItem({
    required BuildContext context,
    required Color bgColor,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDanger ? Colors.red.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isDanger ? FontWeight.w600 : FontWeight.w500,
                  color: isDanger ? Colors.red.shade700 : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDanger ? Colors.red.shade700 : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================
  // DIALOG TENTANG PROGRAM
  // ==========================
  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Tentang Program",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          "Pojok Statistik Kabupaten Tangerang merupakan program kolaborasi "
          "antara Badan Pusat Statistik (BPS) dan pemerintah daerah untuk "
          "meningkatkan literasi statistik masyarakat.\n\n"
          "Program ini menyediakan akses data, edukasi statistik, serta "
          "pendampingan dalam pemanfaatan data sebagai dasar perencanaan "
          "dan pengambilan keputusan.",
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  // ==========================
  // DIALOG KELUAR PROGRAM
  // ==========================
  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Keluar Program",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari halaman pengaturan?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext); // tutup dialog
              Navigator.pop(context); // kembali ke halaman sebelumnya
            },
            child: const Text("Keluar"),
          ),
        ],
      ),
    );
  }

  // ==========================
  // BUILD UI
  // ==========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================
            // HEADER
            // ======================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
              decoration: const BoxDecoration(
                color: Color(0xff0A3A75),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22),
                ),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.settings, color: Color(0xff0A3A75)),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Pojok Statistik",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ======================
            // TITLE
            // ======================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Pengaturan",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0A3A75),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ======================
            // CONTENT
            // ======================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildMenuItem(
                      context: context,
                      bgColor: Colors.blueGrey.shade400,
                      icon: Icons.info_outline,
                      title: "Tentang Program",
                      onTap: () => showAboutDialog(context),
                    ),
                    buildMenuItem(
                      context: context,
                      bgColor: Colors.red.shade300,
                      icon: Icons.exit_to_app,
                      title: "Keluar Program",
                      isDanger: true,
                      onTap: () => showExitDialog(context),
                    ),

                    const SizedBox(height: 40),

                    // ======================
                    // FOOTER
                    // ======================
                    Column(
                      children: [
                        Text(
                          "Versi Aplikasi 1.0.0",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "© 2025 Badan Pusat Statistik",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
