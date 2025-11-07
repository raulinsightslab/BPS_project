// program_selection_screen.dart
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/views/pojok_statistik/widget/pojok_botnav.dart';
import 'package:flutter/material.dart';

class ProgramSelectionScreen extends StatefulWidget {
  const ProgramSelectionScreen({super.key});

  @override
  State<ProgramSelectionScreen> createState() => _ProgramSelectionScreenState();
}

class _ProgramSelectionScreenState extends State<ProgramSelectionScreen> {
  String? selectedProgram;

  final List<String> programs = [
    'Pojok Statistik',
    'Desa Cantik',
    'Pembinaan Sektoral',
  ];

  void _onContinue() {
    if (selectedProgram == 'Pojok Statistik') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PojokMainScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Kamu memilih: $selectedProgram')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Program Pelatihan"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: programs.map((program) {
            return ProgramCard(
              title: program,
              isSelected: program == selectedProgram,
              onTap: () {
                setState(() {
                  selectedProgram = program;
                });
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: selectedProgram != null
          ? FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              onPressed: _onContinue,
              label: const Text("Lanjut"),
              icon: const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.orange.withOpacity(0.2) : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.orange : Colors.black,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check, color: Colors.orange)
            : null,
        onTap: onTap,
      ),
    );
  }
}
