// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   late YoutubePlayerController _controller;
//   String? _playingVideoId;
//   String? _playingVideoUrl;
//   bool _playerError = false;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: '',
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//         enableCaption: false,
//       ),
//     );

//     // Listen for errors
//     _controller.addListener(_handlePlayerEvents);
//   }

//   void _handlePlayerEvents() {
//     if (_controller.value.isReady) {
//       if (mounted) {
//         setState(() {
//           _playerError = false;
//           _errorMessage = '';
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller.removeListener(_handlePlayerEvents);
//     _controller.dispose();
//     super.dispose();
//   }

//   // Extract video ID from YouTube URL
//   String _extractVideoId(String url) {
//     try {
//       if (url.contains('youtu.be/')) {
//         return url.split('youtu.be/').last.split('?').first.split('&').first;
//       } else if (url.contains('youtube.com/watch?v=')) {
//         return url.split('v=').last.split('&').first;
//       }
//       return '';
//     } catch (e) {
//       return '';
//     }
//   }

//   void _playVideo(String url) {
//     final videoId = _extractVideoId(url);

//     if (videoId.isEmpty) {
//       _showError('Link video tidak valid');
//       return;
//     }

//     try {
//       setState(() {
//         _playingVideoId = videoId;
//         _playingVideoUrl = url;
//         _playerError = false;
//         _errorMessage = '';
//       });

//       _controller.load(videoId);

//       // Set a timeout to detect if video fails to load
//       Future.delayed(const Duration(seconds: 5), () {
//         if (mounted &&
//             _playingVideoId == videoId &&
//             !_controller.value.isReady) {
//           _showError(
//             'Video gagal dimuat. Periksa koneksi internet atau coba buka di YouTube.',
//           );
//         }
//       });
//     } catch (e) {
//       _showError('Terjadi kesalahan: ${e.toString()}');
//     }
//   }

//   void _showError(String message) {
//     if (mounted) {
//       setState(() {
//         _playerError = true;
//         _errorMessage = message;
//       });
//     }
//   }

//   void _openInYoutube(String url) {
//     launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication).onError((
//       error,
//       stackTrace,
//     ) {
//       _showError('Tidak bisa membuka YouTube');
//       return false;
//     });
//   }

//   void _closeVideo() {
//     setState(() {
//       _playingVideoId = null;
//       _playingVideoUrl = null;
//       _playerError = false;
//       _errorMessage = '';
//     });
//     _controller.pause();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // HEADER
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
//             decoration: const BoxDecoration(
//               color: Color(0xFF0A2A6B),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "Pojok Statistik",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   "Modul Pembelajaran",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // POSTER
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Image.asset(
//                       "assets/images/potik_ilustrasi.png",
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // VIDEO PLAYER (Show when video is playing)
//                   if (_playingVideoId != null && _playingVideoId!.isNotEmpty)
//                     Column(
//                       children: [
//                         // ERROR MESSAGE
//                         if (_playerError)
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(14),
//                             margin: const EdgeInsets.only(bottom: 16),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFFFE5E5),
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: Colors.red.withOpacity(0.3),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.error_outline,
//                                       color: Colors.red,
//                                       size: 20,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Kesalahan Memuat Video',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Text(
//                                   _errorMessage,
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),
//                                 // Fallback buttons
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: ElevatedButton.icon(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: const Color(
//                                             0xFFF29F05,
//                                           ),
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 8,
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                         ),
//                                         onPressed: () =>
//                                             _openInYoutube(_playingVideoUrl!),
//                                         icon: const Icon(
//                                           Icons.open_in_browser,
//                                           size: 16,
//                                         ),
//                                         label: const Text(
//                                           'Buka di YouTube',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Expanded(
//                                       child: ElevatedButton.icon(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.grey.shade400,
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 8,
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                           ),
//                                         ),
//                                         onPressed: () {
//                                           _closeVideo();
//                                         },
//                                         icon: const Icon(Icons.close, size: 16),
//                                         label: const Text(
//                                           'Tutup',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),

//                         // PLAYER (hide if error)
//                         if (!_playerError)
//                           YoutubePlayer(
//                             controller: _controller,
//                             showVideoProgressIndicator: true,
//                             progressIndicatorColor: const Color(0xFFF29F05),
//                             progressColors: const ProgressBarColors(
//                               playedColor: Color(0xFFF29F05),
//                               handleColor: Color(0xFFF29F05),
//                             ),
//                             onReady: () {
//                               if (mounted) {
//                                 setState(() {
//                                   _playerError = false;
//                                 });
//                               }
//                             },
//                             onEnded: (data) {
//                               // Optional: close player when video ends
//                             },
//                           ),

//                         const SizedBox(height: 16),

//                         // CLOSE BUTTON
//                         if (!_playerError)
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFF29F05),
//                                 padding: const EdgeInsets.symmetric(
//                                   vertical: 12,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               onPressed: _closeVideo,
//                               child: const Text(
//                                 "Tutup Video",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ),

//                         const SizedBox(height: 20),
//                       ],
//                     ),

//                   // 🔥 LIST VIDEO (REAL DATA)
//                   buildVideoCard(
//                     title:
//                         "Sinergi Data BPS dan Google Scholar : Strategi Peneliti Cerdas",
//                     desc:
//                         "Cara cerdas memanfaatkan Google Scholar dan data BPS untuk penelitian yang efektif.",
//                     url: "https://www.youtube.com/watch?v=wAZHwiDd1F4&t=3s",
//                     onPlay: _playVideo,
//                   ),
//                   buildVideoCard(
//                     title:
//                         "Analisis Bibliometrik untuk Penelitian Ilmiah (VOSviewer & Bibliometrix)",
//                     desc:
//                         "Panduan analisis bibliometrik menggunakan VOSviewer dan R Bibliometrix.",
//                     url: "https://youtu.be/PpYQjQ2jjwo",
//                     onPlay: _playVideo,
//                   ),
//                   buildVideoCard(
//                     title:
//                         "Prospek Deep Learning Model untuk Analisis Citra Medis",
//                     desc:
//                         "Pembahasan perkembangan model deep learning untuk mendukung analisis citra medis.",
//                     url: "https://www.youtube.com/watch?v=3JdKTOE3-Uw&t=1s",
//                     onPlay: _playVideo,
//                   ),
//                   buildVideoCard(
//                     title:
//                         "Perkembangan Model Generalized STAR: Menembus Ruang & Waktu",
//                     desc:
//                         "Pengenalan model Generalized STAR serta pemanfaatannya dalam analisis spasial-temporal.",
//                     url: "https://youtu.be/u7c5ERJ1SKw",
//                     onPlay: _playVideo,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =======================================================================
//   // 🔥 VIDEO CARD
//   // =======================================================================
//   Widget buildVideoCard({
//     required String title,
//     required String desc,
//     required String url,
//     required Function(String) onPlay,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // JUDUL
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF0A2A6B),
//             ),
//           ),

//           const SizedBox(height: 6),

//           // DESKRIPSI
//           Text(
//             desc,
//             style: const TextStyle(fontSize: 14, color: Colors.black54),
//           ),

//           const SizedBox(height: 16),

//           // BUTTON — play video in app
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFF29F05),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               onPressed: () => onPlay(url),
//               child: const Text(
//                 "Tonton Video  ▶",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
