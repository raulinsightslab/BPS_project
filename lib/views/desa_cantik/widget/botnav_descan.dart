import 'package:bps_e_learning/views/desa_cantik/screen/home_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/modul_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/settings_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/tugas_screen.dart';
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';

// import 'desa_home.dart';
// import 'desa_modul.dart';
// import 'desa_tugas.dart';
// import 'settings.dart';

class BotnavDescan extends StatefulWidget {
  const BotnavDescan({super.key});

  @override
  State<BotnavDescan> createState() => _BotnavDescanState();
}

class _BotnavDescanState extends State<BotnavDescan> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DesaHomePage(),
    const DesaModulPage(),
    const DesaTugasPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        // Warna latar belakang halaman (cream StaT-Gem)
        color: const Color(0xFFFFF3E0),
        // Padding agar botnav tidak mepet ke tepi
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: CrystalNavigationBar(
          currentIndex: _currentIndex,
          // Warna utama botnav (orange StaT-Gem)
          backgroundColor: const Color(0xFFFFA726),
          // Warna indikator (lebih soft)
          indicatorColor: const Color(0xFFFFB74D),
          // Warna icon ketika aktif
          selectedItemColor: Colors.white,
          // Warna icon ketika tidak aktif
          unselectedItemColor: Colors.white70,
          borderRadius: 25,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

          items: [
            CrystalNavigationBarItem(
              icon: Icons.home_outlined,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: Icons.menu_book_outlined,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: Icons.checklist_outlined,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: Icons.settings_outlined,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
