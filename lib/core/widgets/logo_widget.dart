import 'package:flutter/material.dart';

class BPSLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: AssetImage('assets/images/logo_2.png'),
          fit: BoxFit.cover, // menjaga proporsi gambar
        ),
      ),
    );
  }
}
