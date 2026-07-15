import 'dart:ui';
import 'package:bps_e_learning/views/pembinaan_sektoral/screen/modul_pembinaan.dart';
import 'package:bps_e_learning/views/pembinaan_sektoral/screen/pembinaan_dashboard.dart';
import 'package:bps_e_learning/views/pembinaan_sektoral/screen/settings.dart';
import 'package:flutter/material.dart';

class PembinaanBotnav extends StatefulWidget {
  const PembinaanBotnav({super.key});

  @override
  State<PembinaanBotnav> createState() => _PembinaanBotnavState();
}

class _PembinaanBotnavState extends State<PembinaanBotnav> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SektoralDashboardScreen(),
    PembinaanModulScreen(),
    PembinaanProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xffF4F6F9),
      body: IndexedStack(index: _currentIndex, children: _screens),
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
                  color: Colors.white.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.9),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      iconOutlined: Icons.dashboard_outlined,
                      iconFilled: Icons.dashboard_rounded,
                      label: 'Beranda',
                      index: 0,
                    ),
                    _buildNavItem(
                      iconOutlined: Icons.library_books_outlined,
                      iconFilled: Icons.library_books_rounded,
                      label: 'Modul',
                      index: 1,
                    ),
                    _buildNavItem(
                      iconOutlined: Icons.person_outline,
                      iconFilled: Icons.person_rounded,
                      label: 'Profil',
                      index: 2,
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

  Widget _buildNavItem({
    required IconData iconOutlined,
    required IconData iconFilled,
    required String label,
    required int index,
  }) {
    final bool isActive = _currentIndex == index;
    const activeColor = Color(0xff0A3A75); // Warna navy BPS

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? activeColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: isActive
              ? Border.all(
                  color: activeColor.withValues(alpha: 0.25),
                  width: 1.2,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? iconFilled : iconOutlined,
                key: ValueKey(isActive),
                size: 24,
                color: isActive ? activeColor : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? activeColor : Colors.grey.shade600,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
