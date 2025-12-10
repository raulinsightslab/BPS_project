import 'package:bps_e_learning/views/pojok_statistik/home/pojok_dashboard.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_modul_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_profile_screen.dart';
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
    const TugasScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        // ====== STYLE SESUAI DESAIN ======
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1565C0), // Biru desain kamu
        unselectedItemColor: Colors.grey.shade500,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Modul",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "Tugas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
