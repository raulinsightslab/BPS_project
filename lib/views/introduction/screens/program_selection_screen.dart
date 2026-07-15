import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:bps_e_learning/core/widgets/program_card.dart';
import 'package:bps_e_learning/extensions/extension.dart';
import 'package:bps_e_learning/views/desa_cantik/widget/botnav_descan.dart';
import 'package:bps_e_learning/views/introduction/screens/password_screen.dart';
import 'package:bps_e_learning/views/pembinaan_sektoral/widget/pembinaan_botnav.dart';
import 'package:bps_e_learning/views/pojok_statistik/widget/pojok_botnav.dart';
import 'package:flutter/material.dart';

// ── Model ─────────────────────────────────────────────────────────────────────
class Program {
  final String title;
  final String description;
  final IconData icon;
  final bool requiresPassword;

  const Program({
    required this.title,
    required this.description,
    required this.icon,
    required this.requiresPassword,
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────
class ProgramSelectionPage extends StatefulWidget {
  const ProgramSelectionPage({super.key});

  @override
  State<ProgramSelectionPage> createState() => _ProgramSelectionPageState();
}

class _ProgramSelectionPageState extends State<ProgramSelectionPage> {
  int? _selectedProgramIndex;

  static const List<Program> _programs = [
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

  void _onContinuePressed() {
    if (_selectedProgramIndex == null) return;
    final program = _programs[_selectedProgramIndex!];

    if (program.requiresPassword) {
      context.pushPage(PasswordScreen(programTitle: program.title));
    } else {
      // Langsung masuk tanpa password
      switch (program.title) {
        case 'Pojok Statistik':
          context.pushPage(const PojokMainScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
              AppColors.background,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const BPSLogoWidget(),
              const SizedBox(height: 40),
              Text(
                'Pilih Program Pembelajaran Anda',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _programs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ProgramCard(
                        program: _programs[index],
                        isSelected: _selectedProgramIndex == index,
                        onTap: () =>
                            setState(() => _selectedProgramIndex = index),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              OnboardingButton(
                text: 'Pilih Program Ini',
                onPressed: _selectedProgramIndex != null
                    ? _onContinuePressed
                    : null,
              ),
              const SizedBox(height: 16),
              const PageIndicator(
                currentPage: 2,
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
