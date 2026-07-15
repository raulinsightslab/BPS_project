import 'package:flutter/material.dart';

class BPSLogoWidget extends StatelessWidget {
  const BPSLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset('assets/images/logo_2.png', fit: BoxFit.contain),
      ),
    );
  }
}
