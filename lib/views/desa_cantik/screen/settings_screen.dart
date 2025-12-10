import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                      buildMenuItem(
                        bgColor: Colors.orange.shade300,
                        icon: Icons.person_outline,
                        title: "Profil Pengguna",
                      ),
                      buildMenuItem(
                        bgColor: Colors.blue.shade300,
                        icon: Icons.notifications_none,
                        title: "Notifikasi",
                      ),
                      buildMenuItem(
                        bgColor: Colors.purple.shade300,
                        icon: Icons.color_lens_outlined,
                        title: "Tema Aplikasi",
                      ),
                      buildMenuItem(
                        bgColor: Colors.green.shade300,
                        icon: Icons.privacy_tip_outlined,
                        title: "Privasi & Keamanan",
                      ),
                      buildMenuItem(
                        bgColor: Colors.orange.shade400,
                        icon: Icons.info_outline,
                        title: "Tentang Aplikasi",
                      ),
                      buildMenuItem(
                        bgColor: Colors.red.shade300,
                        icon: Icons.logout,
                        title: "Keluar Akun",
                        isDanger: true,
                      ),
                      SizedBox(height: 40),
                      // Footer tetap dalam scroll
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
