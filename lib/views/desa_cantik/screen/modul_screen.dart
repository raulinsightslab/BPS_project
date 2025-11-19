import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DesaModulPage extends StatefulWidget {
  const DesaModulPage({super.key});

  @override
  State<DesaModulPage> createState() => _DesaModulPageState();
}

class _DesaModulPageState extends State<DesaModulPage> {
  late YoutubePlayerController _ytController;
  int? _selectedModuleIndex;

  final List<Map<String, dynamic>> _modules = [
    {
      'title': 'Pengenalan Statistik Dasar',
      'videoId': '2Vv-BfVoq4g',
      'description':
          'Modul ini membahas dasar-dasar statistik yang diperlukan untuk analisis data desa.',
      'duration': '15:30',
      'fileSize': '2.5 MB',
    },
    {
      'title': 'Cara Input Data Potensi Desa',
      'videoId': 'dQw4w9WgXcQ',
      'description':
          'Pelajari cara menginput data potensi desa dengan benar menggunakan aplikasi BPS.',
      'duration': '22:15',
      'fileSize': '3.1 MB',
    },
    {
      'title': 'Pengenalan Visualisasi Data',
      'videoId': '3JZ_D3ELwOQ',
      'description':
          'Teknik visualisasi data untuk menyajikan informasi desa secara menarik.',
      'duration': '18:45',
      'fileSize': '4.2 MB',
    },
    {
      'title': 'Pemanfaatan Publikasi BPS',
      'videoId': 'L_jWHffIx5E',
      'description': 'Cara memanfaatkan publikasi BPS untuk pengembangan desa.',
      'duration': '25:10',
      'fileSize': '5.0 MB',
    },
  ];

  @override
  void initState() {
    super.initState();
    _ytController = YoutubePlayerController(
      initialVideoId: _modules[0]['videoId'],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _ytController.dispose();
    super.dispose();
  }

  void _onModuleTap(int index) {
    setState(() {
      if (_selectedModuleIndex == index) {
        _selectedModuleIndex = null;
      } else {
        _selectedModuleIndex = index;
        _ytController.load(_modules[index]['videoId']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _ytController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFFF8A00),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFFFF8A00),
          handleColor: Colors.orange,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            title: const Text(
              "Modul Pembelajaran",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFFFF8A00),
            elevation: 0,
          ),

          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        "Video Pembelajaran Desa Cantik",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEB6F00),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                      child: player,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Text(
                "Daftar Modul",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.orange.shade900,
                ),
              ),

              const SizedBox(height: 16),

              ...List.generate(
                _modules.length,
                (index) => _buildModuleCard(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModuleCard(int index) {
    final module = _modules[index];
    final isSelected = _selectedModuleIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? const Color(0xFFFF8A00) : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _onModuleTap(index),

        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: const Color(0xFFFF8A00),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      module['title'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    isSelected ? Icons.expand_less : Icons.expand_more,
                    size: 26,
                    color: const Color(0xFFFF8A00),
                  ),
                ],
              ),

              if (isSelected) ...[
                const SizedBox(height: 16),
                Divider(color: Colors.orange.shade200),
                const SizedBox(height: 14),

                Text(
                  module['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.45,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _buildInfoChip(Icons.timer, module['duration']),
                    const SizedBox(width: 8),
                    _buildInfoChip(Icons.file_download, module['fileSize']),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text("Download Modul"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8A00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFFFF8A00)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFFBB5400),
            ),
          ),
        ],
      ),
    );
  }
}
