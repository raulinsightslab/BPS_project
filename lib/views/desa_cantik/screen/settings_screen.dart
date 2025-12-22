import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget buildMenuItem({
    required BuildContext context,
    required Color bgColor,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
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

  // =========================
  // DIALOG: TENTANG APLIKASI
  // =========================
  void showAboutDialogApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Tentang Aplikasi",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            "Aplikasi Desa Cantik (Desa Cinta Statistik) merupakan aplikasi "
            "pendukung program Badan Pusat Statistik (BPS) dalam meningkatkan "
            "literasi data dan kualitas pengelolaan statistik di tingkat desa.\n\n"
            "Aplikasi ini membantu perangkat desa dalam memahami, mengelola, "
            "dan memanfaatkan data statistik secara efektif untuk perencanaan "
            "dan pengambilan kebijakan berbasis data.",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // DIALOG: KONFIRMASI KELUAR
  // =========================
  void showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Konfirmasi",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text(
            "Apakah Anda yakin ingin keluar dari Program Desa Cantik?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                "Keluar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pengaturan",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange.shade900,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Tentang Aplikasi
                      buildMenuItem(
                        context: context,
                        bgColor: Colors.orange.shade400,
                        icon: Icons.info_outline,
                        title: "Tentang Aplikasi",
                        onTap: () => showAboutDialogApp(context),
                      ),

                      // Keluar Program
                      buildMenuItem(
                        context: context,
                        bgColor: Colors.red.shade400,
                        icon: Icons.exit_to_app,
                        title: "Keluar Program",
                        isDanger: true,
                        onTap: () => showExitConfirmation(context),
                      ),

                      const SizedBox(height: 40),

                      // Footer
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
      ),
    );
  }
}
