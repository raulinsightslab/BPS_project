import 'dart:ui';
import 'package:flutter/material.dart';

// Ganti import sesuai struktur project lo
import 'package:bps_e_learning/views/pojok_statistik/home/dashboard_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/settings_screen.dart';

class PojokMainScreen extends StatefulWidget {
  const PojokMainScreen({super.key});

  @override
  State<PojokMainScreen> createState() => _PojokMainScreenState();
}

class _PojokMainScreenState extends State<PojokMainScreen> {
  int _currentIndex = 0;

  // ✅ Hanya 2 screen: Modul & Settings
  final List<Widget> _screens = [const DashboardScreen(), const SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],

      bottomNavigationBar: Padding(
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
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(
                      iconOutlined: Icons.dashboard_outlined,
                      iconFilled: Icons.dashboard_rounded,
                      label: "Modul",
                      index: 0,
                    ),
                    _navItem(
                      iconOutlined: Icons.settings_outlined,
                      iconFilled: Icons.settings_rounded,
                      label: "Settings",
                      index: 1, // ✅ FIX (bukan 2 lagi)
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

  Widget _navItem({
    required IconData iconOutlined,
    required IconData iconFilled,
    required String label,
    required int index,
  }) {
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
