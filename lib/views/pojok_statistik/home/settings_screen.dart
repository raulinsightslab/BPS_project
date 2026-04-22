import 'package:flutter/material.dart';

// ─── Colors ───────────────────────────────────────────────────────────────────
class _C {
  static const Color navy = Color(0xFF0A2A6B);
  static const Color navyLight = Color(0xFF1565C0);
  static const Color orange = Color(0xFFF29F05);
  static const Color orangeDark = Color(0xFFE65100);
  static const Color bg = Color(0xFFF0F4FA);
  static const Color cardBorder = Color(0xFFD6E4F7);
  static const Color textSecondary = Color(0xFF607D8B);
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // ==========================
  // HEADER BUILDER
  // ==========================
  Widget _buildHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 16, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.navy, _C.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo row
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _C.orange,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'PS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pojok Statistik',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'BPS Kabupaten Tangerang',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Headline
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Kelola preferensi dan informasi aplikasi',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _C.cardBorder, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: _C.navy.withOpacity(0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.red.shade100
                    : bgColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isDanger ? Colors.red.shade700 : bgColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDanger ? Colors.red.shade700 : _C.navy,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDanger ? Colors.red.shade400 : _C.textSecondary,
              size: 22,
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
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: _C.navy,
            fontSize: 16,
          ),
        ),
        content: const Text(
          "Pojok Statistik Kabupaten Tangerang merupakan program kolaborasi "
          "antara Badan Pusat Statistik (BPS) dan pemerintah daerah untuk "
          "meningkatkan literasi statistik masyarakat.\n\n"
          "Program ini menyediakan akses data, edukasi statistik, serta "
          "pendampingan dalam pemanfaatan data sebagai dasar perencanaan "
          "dan pengambilan keputusan.",
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 13, color: _C.textSecondary, height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup", style: TextStyle(color: _C.orange)),
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
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: _C.navy,
            fontSize: 16,
          ),
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari halaman pengaturan?",
          style: TextStyle(fontSize: 13, color: _C.textSecondary, height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              "Batal",
              style: TextStyle(color: _C.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text(
              "Keluar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
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
      backgroundColor: _C.bg,
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                // Tentang Program
                buildMenuItem(
                  context: context,
                  bgColor: _C.navy,
                  icon: Icons.info_outline_rounded,
                  title: "Tentang Program",
                  onTap: () => showAboutDialog(context),
                ),

                // Keluar Program
                buildMenuItem(
                  context: context,
                  bgColor: Colors.red,
                  icon: Icons.exit_to_app_rounded,
                  title: "Keluar Program",
                  isDanger: true,
                  onTap: () => showExitDialog(context),
                ),

                const SizedBox(height: 32),

                // Footer
                Column(
                  children: [
                    Text(
                      "Versi Aplikasi 1.0.0",
                      style: TextStyle(
                        color: _C.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "© 2025 Badan Pusat Statistik",
                      style: TextStyle(
                        color: _C.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
