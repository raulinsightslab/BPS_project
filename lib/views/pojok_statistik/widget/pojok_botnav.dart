import 'dart:ui';
import 'package:bps_e_learning/views/pojok_statistik/home/dashboard_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_modul_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/settings_screen.dart';
import 'package:flutter/material.dart';

class PojokMainScreen extends StatefulWidget {
  const PojokMainScreen({super.key});

  @override
  State<PojokMainScreen> createState() => _PojokMainScreenState();
}

class _PojokMainScreenState extends State<PojokMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    // const TugasScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true wajib agar konten bisa "tembus" ke bawah navbar
      extendBody: true,
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Padding(
        // Navbar melayang: padding bawah + kiri kanan
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom
              : 16,
          left: 16,
          right: 16,
        ),
        child: SizedBox(
          height: 68,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                decoration: BoxDecoration(
                  // Transparan kaya Telegram: putih dengan opacity rendah
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.9),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      Icons.dashboard_outlined,
                      Icons.dashboard_rounded,
                      "Modul",
                      0,
                    ),
                    // _navItem(
                    //   Icons.assignment_outlined,
                    //   Icons.assignment_rounded,
                    //   "Tugas",
                    //   1,
                    // ),
                    _navItem(
                      Icons.settings_outlined,
                      Icons.settings_rounded,
                      "Settings",
                      2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    IconData iconOutlined,
    IconData iconFilled,
    String label,
    int index,
  ) {
    final bool active = _currentIndex == index;
    const activeColor = Color(0xFF1565C0);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: active ? activeColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: active
              ? Border.all(color: activeColor.withOpacity(0.25), width: 1.2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                active ? iconFilled : iconOutlined,
                key: ValueKey(active),
                size: 24,
                color: active ? activeColor : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? activeColor : Colors.grey.shade600,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
