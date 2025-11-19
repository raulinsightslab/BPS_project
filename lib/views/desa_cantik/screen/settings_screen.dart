import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                "Pengaturan",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange.shade900,
                ),
              ),
              const SizedBox(height: 20),

              ListTile(
                leading: Icon(
                  Icons.color_lens_outlined,
                  color: Colors.orange.shade900,
                ),
                title: const Text("Tema Aplikasi"),
                trailing: const Icon(Icons.chevron_right),
              ),

              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Colors.orange.shade900,
                ),
                title: const Text("Tentang Aplikasi"),
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
