import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bps_e_learning/views/login.dart';

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
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Kelola preferensi dan informasi aplikasi',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ==========================
  // MENU ITEM
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
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDanger ? Colors.red.shade700 : _C.navy,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: _C.textSecondary),
          ],
        ),
      ),
    );
  }

  // ==========================
  // ABOUT DIALOG
  // ==========================
  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        content: Text(
          "Pojok Statistik Kabupaten Tangerang merupakan program kolaborasi "
          "antara Badan Pusat Statistik (BPS) dan pemerintah daerah untuk "
          "meningkatkan literasi statistik masyarakat.\n\n"
          "Program ini menyediakan akses data, edukasi statistik, serta "
          "pendampingan dalam pemanfaatan data sebagai dasar perencanaan "
          "dan pengambilan keputusan.",
        ),
      ),
    );
  }

  // ==========================
  // 🔥 LOGOUT DIALOG (FIX)
  // ==========================
  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.w700, color: _C.navy),
        ),
        content: const Text(
          "Apakah Anda yakin ingin keluar dari akun?",
          style: TextStyle(color: _C.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _C.orange),
            onPressed: () async {
              // 🔥 LOGOUT FIREBASE
              await FirebaseAuth.instance.signOut();

              Navigator.pop(dialogContext);

              // 🔥 RESET KE LOGIN
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  // ==========================
  // BUILD
  // ==========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                buildMenuItem(
                  context: context,
                  bgColor: _C.navy,
                  icon: Icons.info,
                  title: "Tentang Program",
                  onTap: () => showAboutDialog(context),
                ),
                buildMenuItem(
                  context: context,
                  bgColor: Colors.red,
                  icon: Icons.logout,
                  title: "Logout",
                  isDanger: true,
                  onTap: () => showExitDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
