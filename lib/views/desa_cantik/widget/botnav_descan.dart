import 'dart:ui';
import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/views/desa_cantik/kuis/kuis_list.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/learning_descan.dart';
import 'package:bps_e_learning/views/desa_cantik/screen/settings_screen.dart';
import 'package:flutter/material.dart';

class BotnavDescan extends StatefulWidget {
  const BotnavDescan({super.key});

  @override
  State<BotnavDescan> createState() => _BotnavDescanState();
}

class _BotnavDescanState extends State<BotnavDescan> {
  int _currentIndex = 0;

  // FIX: gunakan IndexedStack untuk lazy loading + preserve state
  static const _screens = [
    DesaCantikLearningScreen(),
    ModuleListScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.desaBg,
      body: IndexedStack(index: _currentIndex, children: _screens),
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
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.95),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 35,
                      spreadRadius: 3,
                      offset: const Offset(0, 18),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
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
                      _navItem(Icons.menu_book_rounded, 'Modul', 0),
                      _navItem(Icons.assignment_rounded, 'Tugas', 1),
                      _navItem(Icons.settings_rounded, 'Setting', 2),
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
          color: active
              ? Colors.white.withValues(alpha: 0.35)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: active
              ? Border.all(
                  color: Colors.orange.shade600.withValues(alpha: 0.5),
                  width: 1.5,
                )
              : null,
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.18),
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
