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
    PembinaanDashboard(),
    PembinaanModulScreen(),
    PembinaanProfileScreen(),
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
        // ====== STYLE IKUT DESAIN POJOK STATISTIK ======
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "Modul",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
