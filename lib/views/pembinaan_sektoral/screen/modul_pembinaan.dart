import 'package:flutter/material.dart';

class PembinaanModulScreen extends StatelessWidget {
  const PembinaanModulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Modul Pembinaan Sektoral',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Modul',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildModuleCard(
              title: 'Evaluasi Penyelenggaraan Statistik Sektoral (EPSS)',
              description:
                  'Evaluasi atas pelaksanaan penyelenggaraan statistik sektoral untuk meningkatkan kualitas dan tata kelola data.',
              icon: Icons.assessment_outlined,
              color: Colors.blue,
              onTap: () => _openDownloadPage(context, 'EPSS'),
            ),

            _buildModuleCard(
              title: 'Identifikasi Kegiatan Statistik',
              description:
                  'Mengidentifikasi kegiatan statistik dalam instansi untuk memastikan kesesuaian dengan standar dan kebutuhan nasional.',
              icon: Icons.search_outlined,
              color: Colors.green,
              onTap: () =>
                  _openDownloadPage(context, 'Identifikasi Kegiatan Statistik'),
            ),

            _buildModuleCard(
              title: 'Satu Data Indonesia',
              description:
                  'Pemahaman prinsip, peran, dan pelaksanaan Satu Data Indonesia dalam pengelolaan data pemerintah.',
              icon: Icons.data_usage_outlined,
              color: Colors.orange,
              onTap: () => _openDownloadPage(context, 'Satu Data Indonesia'),
            ),

            _buildModuleCard(
              title: 'Kualitas Data',
              description:
                  'Standar dan tahapan peningkatan kualitas data agar memenuhi kaidah statistik yang baik.',
              icon: Icons.verified_outlined,
              color: Colors.purple,
              onTap: () => _openDownloadPage(context, 'Kualitas Data'),
            ),

            _buildModuleCard(
              title: 'Proses Bisnis Statistik',
              description:
                  'Penjelasan alur kegiatan statistik mulai dari perencanaan hingga diseminasi.',
              icon: Icons.loop_outlined,
              color: Colors.teal,
              onTap: () =>
                  _openDownloadPage(context, 'Proses Bisnis Statistik'),
            ),

            _buildModuleCard(
              title: 'Kelembagaan Statistik',
              description:
                  'Struktur, peran, dan koordinasi kelembagaan dalam penyelenggaraan statistik.',
              icon: Icons.account_balance_outlined,
              color: Colors.red,
              onTap: () => _openDownloadPage(context, 'Kelembagaan Statistik'),
            ),

            _buildModuleCard(
              title: 'Sistem Statistik Nasional (SSN)',
              description:
                  'Gambaran sistem statistik nasional sebagai kerangka integrasi statistik di Indonesia.',
              icon: Icons.public_outlined,
              color: Colors.indigo,
              onTap: () =>
                  _openDownloadPage(context, 'Sistem Statistik Nasional'),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _openDownloadPage(BuildContext context, String modulName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('Download $modulName')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Halaman download untuk ' + modulName),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Download Modul'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
