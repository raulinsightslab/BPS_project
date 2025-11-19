import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:bps_e_learning/core/widgets/program_card.dart';
import 'package:bps_e_learning/views/desa_cantik/widget/botnav_descan.dart';
import 'package:bps_e_learning/views/introduction/screens/password_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/auth/login_screen.dart';
import 'package:bps_e_learning/views/pojok_statistik/widget/pojok_botnav.dart';
import 'package:flutter/material.dart';

class ProgramSelectionPage extends StatefulWidget {
  @override
  _ProgramSelectionPageState createState() => _ProgramSelectionPageState();
}

class _ProgramSelectionPageState extends State<ProgramSelectionPage> {
  int? _selectedProgramIndex;

  final List<Program> _programs = [
    Program(
      title: 'Pojok Statistik',
      description: 'Pembelajaran umum dari BPS',
      icon: Icons.analytics_outlined,
      requiresPassword: false,
    ),
    Program(
      title: 'Desa Cantik',
      description: 'Masukkan password untuk mengakses program ini.',
      icon: Icons.landscape_outlined,
      requiresPassword: true,
    ),
    Program(
      title: 'Pembinaan Sektoral',
      description: 'Masukkan password untuk mengakses program ini.',
      icon: Icons.business_center_outlined,
      requiresPassword: true,
    ),
  ];

  void _onProgramSelected(int index) {
    setState(() {
      _selectedProgramIndex = index;
    });
  }

  void _onContinuePressed() {
    if (_selectedProgramIndex == null) return;

    final selectedProgram = _programs[_selectedProgramIndex!];

    if (selectedProgram.requiresPassword) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => BotnavDescan()));
    } else {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => PojokMainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFFE0B2), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 60),

              // BPS Logo
              BPSLogoWidget(),
              SizedBox(height: 40),

              // Headline
              Text(
                'Pilih Program Pembelajaran Anda',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Program Cards
              Expanded(
                child: ListView.builder(
                  itemCount: _programs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ProgramCard(
                        program: _programs[index],
                        isSelected: _selectedProgramIndex == index,
                        onTap: () => _onProgramSelected(index),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),

              // Select Program Button
              OnboardingButton(
                text: 'Pilih Program Ini',
                onPressed: _selectedProgramIndex != null
                    ? _onContinuePressed
                    : null,
              ),
              SizedBox(height: 16),

              // Page Indicator
              PageIndicator(
                currentPage: 3,
                totalPages: 3,
                activeColor: Color(0xFFFFA726),
                inactiveColor: Color(0xFFFFE0B2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Program {
  final String title;
  final String description;
  final IconData icon;
  final bool requiresPassword;

  Program({
    required this.title,
    required this.description,
    required this.icon,
    required this.requiresPassword,
  });
}
