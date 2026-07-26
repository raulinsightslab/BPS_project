// import 'package:bps_e_learning/views/auth_service.dart';
// import 'package:bps_e_learning/views/register.dart';
// import 'package:bps_e_learning/views/pembinaan_sektoral/widget/pembinaan_botnav.dart';
// import 'package:bps_e_learning/views/desa_cantik/widget/botnav_descan.dart';
// import 'package:bps_e_learning/views/pojok_statistik/widget/pojok_botnav.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// /// 🎯 Combined Screen: Program Selection + Login
// /// User flow: Select Program → Login → Navigate to Program
// class ProgramLoginCombinedScreen extends StatefulWidget {
//   const ProgramLoginCombinedScreen({super.key});

//   @override
//   State<ProgramLoginCombinedScreen> createState() =>
//       _ProgramLoginCombinedScreenState();
// }

// class _ProgramLoginCombinedScreenState
//     extends State<ProgramLoginCombinedScreen> {
//   // ═══════════════════════════════════════════════════════════════════════════
//   // STATE MANAGEMENT
//   // ═══════════════════════════════════════════════════════════════════════════

//   final PageController _pageController = PageController();
//   int _currentPage = 0; // 0 = Program Selection, 1 = Login

//   // Program Selection
//   int? _selectedProgramIndex;

//   final List<Program> _programs = [
//     Program(
//       title: 'Pojok Statistik',
//       description: 'Pembelajaran umum dari BPS',
//       icon: Icons.analytics_outlined,
//       requiresPassword: false,
//     ),
//     Program(
//       title: 'Desa Cantik',
//       description: 'Program pembelajaran Desa Cantik',
//       icon: Icons.landscape_outlined,
//       requiresPassword: true,
//     ),
//     Program(
//       title: 'Pembinaan Sektoral',
//       description: 'Program pembinaan sektoral BPS',
//       icon: Icons.business_center_outlined,
//       requiresPassword: true,
//     ),
//   ];

//   // Login Form
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _authService = AuthService();

//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }

//   // ═══════════════════════════════════════════════════════════════════════════
//   // PROGRAM SELECTION LOGIC
//   // ═══════════════════════════════════════════════════════════════════════════

//   void _onProgramSelected(int index) {
//     setState(() {
//       _selectedProgramIndex = index;
//     });
//   }

//   void _onContinueToLogin() {
//     if (_selectedProgramIndex == null) return;

//     // Navigate to login page
//     _pageController.animateToPage(
//       1,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }

//   // ═══════════════════════════════════════════════════════════════════════════
//   // LOGIN LOGIC
//   // ═══════════════════════════════════════════════════════════════════════════

//   Future<void> _handleLogin() async {
//     if (!_formKey.currentState!.validate()) return;
//     if (_selectedProgramIndex == null) return;

//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       // Login user
//       await _authService.loginWithEmail(
//         email: _emailCtrl.text,
//         password: _passwordCtrl.text,
//       );

//       // Save selected program to preferences
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(
//         'selectedProgram',
//         _programs[_selectedProgramIndex!].title,
//       );

//       if (!mounted) return;

//       // Navigate to selected program
//       _navigateToProgram(_programs[_selectedProgramIndex!]);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = AuthService.getErrorMessage(e.code);
//       });
//     } catch (_) {
//       setState(() {
//         _errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
//       });
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _navigateToProgram(Program program) {
//     Widget destination;

//     switch (program.title) {
//       case 'Pojok Statistik':
//         destination = const PojokMainScreen();
//         break;
//       case 'Desa Cantik':
//         destination = const BotnavDescan();
//         break;
//       case 'Pembinaan Sektoral':
//         destination = const PembinaanBotnav();
//         break;
//       default:
//         return;
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => destination),
//     );
//   }

//   Future<void> _handleForgotPassword() async {
//     final email = _emailCtrl.text.trim();
//     if (email.isEmpty) {
//       setState(() => _errorMessage = 'Masukkan email Anda terlebih dahulu.');
//       return;
//     }

//     try {
//       await _authService.sendPasswordResetEmail(email);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Link reset password dikirim ke $email'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() => _errorMessage = AuthService.getErrorMessage(e.code));
//     }
//   }

//   void _goBackToPrograms() {
//     _pageController.animateToPage(
//       0,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }

//   // ═══════════════════════════════════════════════════════════════════════════
//   // UI BUILD
//   // ═══════════════════════════════════════════════════════════════════════════

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(), // Disable swipe
//         onPageChanged: (page) => setState(() => _currentPage = page),
//         children: [_buildProgramSelectionPage(), _buildLoginPage()],
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // PAGE 1: PROGRAM SELECTION
//   // ───────────────────────────────────────────────────────────────────────────

//   Widget _buildProgramSelectionPage() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFFFFA726), Color(0xFFFFE0B2), Color(0xFFFFFFFF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),

//               // Logo
//               Container(
//                 width: 72,
//                 height: 72,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFFF59E0B), Color(0xFFE65100)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
//                       blurRadius: 20,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'BPS',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w900,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 32),

//               Text(
//                 'Pilih Program Pembelajaran',
//                 style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                   color: const Color(0xFF212121),
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 8),

//               const Text(
//                 'Pilih program yang ingin Anda ikuti',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF616161)),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 32),

//               // Program Cards
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _programs.length,
//                   itemBuilder: (context, index) {
//                     final program = _programs[index];
//                     final isSelected = _selectedProgramIndex == index;

//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 16.0),
//                       child: _buildProgramCard(program, isSelected, index),
//                     );
//                   },
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Continue Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: _selectedProgramIndex != null
//                       ? _onContinueToLogin
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF59E0B),
//                     disabledBackgroundColor: const Color(
//                       0xFFF59E0B,
//                     ).withValues(alpha: 0.5),
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: const Text(
//                     'Lanjutkan',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProgramCard(Program program, bool isSelected, int index) {
//     return GestureDetector(
//       onTap: () => _onProgramSelected(index),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected ? const Color(0xFFF59E0B) : Colors.transparent,
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isSelected
//                   ? const Color(0xFFF59E0B).withValues(alpha: 0.2)
//                   : Colors.black.withValues(alpha: 0.05),
//               blurRadius: isSelected ? 12 : 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 56,
//               height: 56,
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
//                     : const Color(0xFFF4F6FA),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 program.icon,
//                 color: isSelected
//                     ? const Color(0xFFF59E0B)
//                     : const Color(0xFF616161),
//                 size: 28,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     program.title,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: isSelected
//                           ? const Color(0xFFF59E0B)
//                           : const Color(0xFF212121),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     program.description,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Color(0xFF616161),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               const Icon(
//                 Icons.check_circle_rounded,
//                 color: Color(0xFFF59E0B),
//                 size: 28,
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // PAGE 2: LOGIN
//   // ───────────────────────────────────────────────────────────────────────────

//   Widget _buildLoginPage() {
//     return Container(
//       color: const Color(0xFFF4F6FA),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 24),

//               // Back Button
//               IconButton(
//                 onPressed: _goBackToPrograms,
//                 icon: const Icon(Icons.arrow_back, color: Color(0xFF0A2A6B)),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),

//               const SizedBox(height: 24),

//               // Header
//               Center(
//                 child: Container(
//                   width: 72,
//                   height: 72,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFF59E0B), Color(0xFFE65100)],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'BPS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w900,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 28),

//               const Center(
//                 child: Text(
//                   'Selamat Datang!',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w800,
//                     color: Color(0xFF0A2A6B),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 6),

//               if (_selectedProgramIndex != null)
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           _programs[_selectedProgramIndex!].icon,
//                           size: 16,
//                           color: const Color(0xFFF59E0B),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           _programs[_selectedProgramIndex!].title,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFFF59E0B),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 32),

//               // Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Email
//                     _buildTextField(
//                       controller: _emailCtrl,
//                       label: 'Email',
//                       hint: 'contoh@email.com',
//                       icon: Icons.email_outlined,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (val) {
//                         if (val == null || val.trim().isEmpty) {
//                           return 'Email tidak boleh kosong';
//                         }
//                         if (!RegExp(
//                           r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$',
//                         ).hasMatch(val.trim())) {
//                           return 'Format email tidak valid';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 16),

//                     // Password
//                     _buildTextField(
//                       controller: _passwordCtrl,
//                       label: 'Password',
//                       hint: 'Minimal 6 karakter',
//                       icon: Icons.lock_outline_rounded,
//                       obscureText: _obscurePassword,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off_outlined
//                               : Icons.visibility_outlined,
//                           color: const Color(0xFF6B7A99),
//                           size: 20,
//                         ),
//                         onPressed: () => setState(
//                           () => _obscurePassword = !_obscurePassword,
//                         ),
//                       ),
//                       validator: (val) {
//                         if (val == null || val.isEmpty) {
//                           return 'Password tidak boleh kosong';
//                         }
//                         if (val.length < 6) {
//                           return 'Password minimal 6 karakter';
//                         }
//                         return null;
//                       },
//                     ),

//                     // Forgot Password
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: _handleForgotPassword,
//                         child: const Text(
//                           'Lupa Password?',
//                           style: TextStyle(
//                             color: Color(0xFFF59E0B),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Error Message
//                     if (_errorMessage != null) ...[
//                       const SizedBox(height: 4),
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 14,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.red.shade200),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.error_outline,
//                               color: Colors.red.shade600,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 _errorMessage!,
//                                 style: TextStyle(
//                                   color: Colors.red.shade700,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],

//                     const SizedBox(height: 24),

//                     // Login Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: _isLoading ? null : _handleLogin,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFF59E0B),
//                           disabledBackgroundColor: const Color(
//                             0xFFF59E0B,
//                           ).withValues(alpha: 0.6),
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: _isLoading
//                             ? const SizedBox(
//                                 width: 22,
//                                 height: 22,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2.5,
//                                 ),
//                               )
//                             : const Text(
//                                 'Masuk',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // Divider
//               Row(
//                 children: [
//                   Expanded(
//                     child: Divider(color: Colors.grey.shade300, height: 1),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Text(
//                       'atau',
//                       style: TextStyle(
//                         color: Colors.grey.shade500,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Divider(color: Colors.grey.shade300, height: 1),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),

//               // Register Link
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Belum punya akun? ',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 14,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const RegisterScreen(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'Daftar Sekarang',
//                         style: TextStyle(
//                           color: Color(0xFFF59E0B),
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ───────────────────────────────────────────────────────────────────────────
//   // REUSABLE WIDGETS
//   // ───────────────────────────────────────────────────────────────────────────

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF0A2A6B),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           obscureText: obscureText,
//           validator: validator,
//           style: const TextStyle(fontSize: 14, color: Color(0xFF0A2A6B)),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
//             prefixIcon: Icon(icon, color: const Color(0xFF6B7A99), size: 20),
//             suffixIcon: suffixIcon,
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 14,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(
//                 color: Color(0xFFF59E0B),
//                 width: 1.5,
//               ),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.red.shade400, width: 1),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════════════════
// // PROGRAM MODEL
// // ═══════════════════════════════════════════════════════════════════════════

// class Program {
//   final String title;
//   final String description;
//   final IconData icon;
//   final bool requiresPassword;

//   Program({
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.requiresPassword,
//   });
// }
