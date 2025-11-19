import 'dart:ui';
import 'package:bps_e_learning/views/desa_cantik/screen/home_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/learning_page.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/modul_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/settings_screen.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/tugas_screen.dart';
import 'package:flutter/material.dart';

class BotnavDescan extends StatefulWidget {
  const BotnavDescan({super.key});

  @override
  State<BotnavDescan> createState() => _BotnavDescanState();
}

class _BotnavDescanState extends State<BotnavDescan> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DesaHomePage(),
    const LearningPage(),
    const DesaTugasPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFFFF3E0),

      body: _screens[_currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          height: 90,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.92,
                height: 82,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(40),

                  /// 🔥 OUTLINE TEBAL & JELAS
                  border: Border.all(
                    color: Colors.white.withOpacity(0.95),
                    width: 1.4,
                  ),

                  /// 🔥 DOUBLE SHADOW (BIAR FLOATING BANGET)
                  boxShadow: [
                    // Shadow bawah — soft glow
                    BoxShadow(
                      color: Colors.black.withOpacity(0.14),
                      blurRadius: 35,
                      spreadRadius: 3,
                      offset: const Offset(0, 18),
                    ),
                    // Shadow atas — biar ada depth seperti botnav terangkat
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      spreadRadius: 1,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),

                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navItem(Icons.home_rounded, "Home", 0),
                      _navItem(Icons.menu_book_rounded, "Modul", 1),
                      _navItem(Icons.assignment_rounded, "Tugas", 2),
                      _navItem(Icons.settings_rounded, "Setting", 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool active = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.35) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),

          /// 🔥 HIGHLIGHT ACTIVE (lebih premium)
          border: active
              ? Border.all(
                  color: Colors.orange.shade600.withOpacity(0.5),
                  width: 1.5,
                )
              : null,

          /// Slight shadow for active item (biar timbul)
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: active ? Colors.orange.shade700 : Colors.black87,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                color: active ? Colors.orange.shade700 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
