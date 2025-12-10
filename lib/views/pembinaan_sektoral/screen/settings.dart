import 'package:flutter/material.dart';

class PembinaanProfileScreen extends StatelessWidget {
  const PembinaanProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profil Pembinaan Sektoral',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
