import 'package:bps_e_learning/views/pembinaan_sektoral/widget/pembinaan_botnav.dart';
import 'package:flutter/material.dart';
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:bps_e_learning/core/widgets/program_card.dart';
import 'package:bps_e_learning/views/desa_cantik/widget/botnav_descan.dart';
import 'package:bps_e_learning/views/pojok_statistik/widget/pojok_botnav.dart';

// ⬆ Pastikan nama file & class benar

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

  /// ROUTING BARU (yang kamu minta)
  void _onContinuePressed() {
    if (_selectedProgramIndex == null) return;

    final selectedProgram = _programs[_selectedProgramIndex!];

    switch (selectedProgram.title) {
      case 'Pojok Statistik':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PojokMainScreen()),
        );
        break;

      case 'Desa Cantik':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BotnavDescan()),
        );
        break;

      case 'Pembinaan Sektoral':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PembinaanBotnav()),
        );
        break;
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

              BPSLogoWidget(),
              SizedBox(height: 40),

              Text(
                'Pilih Program Pembelajaran Anda',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

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

              OnboardingButton(
                text: 'Pilih Program Ini',
                onPressed: _selectedProgramIndex != null
                    ? _onContinuePressed
                    : null,
              ),
              SizedBox(height: 16),

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
