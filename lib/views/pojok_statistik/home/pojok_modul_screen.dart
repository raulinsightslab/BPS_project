// modul_screen.dart
import 'package:flutter/material.dart';

class ModulScreen extends StatelessWidget {
  const ModulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text('Halaman Modul - Akses Modul Materi')),
    );
  }
}
