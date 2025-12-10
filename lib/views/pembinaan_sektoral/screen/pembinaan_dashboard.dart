import 'package:flutter/material.dart';

class PembinaanDashboard extends StatelessWidget {
  const PembinaanDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Dashboard Pembinaan Sektoral',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
