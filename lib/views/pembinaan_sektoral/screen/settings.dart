import 'package:flutter/material.dart';

class PembinaanProfileScreen extends StatelessWidget {
  const PembinaanProfileScreen({super.key});

  // ==========================
  // MENU ITEM BUILDER
  // ==========================
  Widget buildMenuItem({
    required Color bgColor,
    required IconData icon,
    required String title,
    Color? iconColor,
    bool isDanger = false,
  }) {
    return Container(
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
            child: Icon(icon, color: iconColor ?? Colors.white),
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
            // TITLE
            // ======================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Pengaturan Pembinaan",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0A3A75),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // ======================
            // SCROLL CONTENT
            // ======================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildMenuItem(
                      bgColor: Colors.blue.shade400,
                      icon: Icons.person_outline,
                      title: "Profil Pengguna",
                    ),
                    buildMenuItem(
                      bgColor: Colors.green.shade400,
                      icon: Icons.notifications_none,
                      title: "Notifikasi",
                    ),
                    buildMenuItem(
                      bgColor: Colors.purple.shade400,
                      icon: Icons.color_lens_outlined,
                      title: "Tema Aplikasi",
                    ),
                    buildMenuItem(
                      bgColor: Colors.orange.shade400,
                      icon: Icons.privacy_tip_outlined,
                      title: "Privasi & Keamanan",
                    ),
                    buildMenuItem(
                      bgColor: Colors.blueGrey.shade400,
                      icon: Icons.info_outline,
                      title: "Tentang Aplikasi",
                    ),
                    buildMenuItem(
                      bgColor: Colors.red.shade300,
                      icon: Icons.logout,
                      title: "Keluar Akun",
                      isDanger: true,
                    ),

                    const SizedBox(height: 40),

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
