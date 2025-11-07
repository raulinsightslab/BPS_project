// pojok_main_screen.dart
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_dashboard.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_modul_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/home/pojok_profile_screen.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
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
    const ModulScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: _currentIndex,
        borderRadius: 25,
        backgroundColor: Colors.orange,
        indicatorColor: Colors.orange,
        unselectedItemColor: Colors.grey.shade400,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          CrystalNavigationBarItem(
            icon: Icons.dashboard_outlined,
            selectedColor: Colors.white,
            // title: Text(
            //   'Dashboard',
            //   style: TextStyle(
            //     color: _currentIndex == 0 ? Colors.orange : Colors.grey.shade400,
            //     fontSize: 12,
            //     fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
            //   ),
            // ),
          ),
          CrystalNavigationBarItem(
            icon: Icons.library_books_outlined,
            selectedColor: Colors.white,
            // : Text(
            //   'Modul',
            //   style: TextStyle(
            //     color: _currentIndex == 1 ? Colors.orange : Colors.grey.shade400,
            //     fontSize: 12,
            //     fontWeight: _currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
            //   ),
            // ),
          ),
          CrystalNavigationBarItem(
            icon: Icons.person_outlined,
            selectedColor: Colors.white,
            // title: Text(
            //   'Profile',
            //   style: TextStyle(
            //     color: _currentIndex == 2 ? Colors.orange : Colors.grey.shade400,
            //     fontSize: 12,
            //     fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
