// import 'package:bps_e_learning/core/utils/app_colors.dart';
// import 'package:bps_e_learning/core/widgets/logo_widget.dart';
// import 'package:bps_e_learning/extensions/extension.dart';
// import 'package:bps_e_learning/views/desa_cantik/widget/botnav_descan.dart';
// import 'package:bps_e_learning/views/pembinaan_sektoral/widget/pembinaan_botnav.dart';
// import 'package:flutter/material.dart';

// class PasswordScreen extends StatefulWidget {
//   final String programTitle;

//   const PasswordScreen({super.key, required this.programTitle});

//   @override
//   State<PasswordScreen> createState() => _PasswordScreenState();
// }

// class _PasswordScreenState extends State<PasswordScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();

//   bool _isObscure = true;
//   bool _hasError = false;
//   bool _isLoading = false;

//   late AnimationController _shakeController;
//   late Animation<double> _shakeAnimation;

//   // Password mapping per program
//   static const Map<String, String> _programPasswords = {
//     'Desa Cantik': 'DesCan123',
//     'Pembinaan Sektoral': 'Pembinaan123',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _shakeController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
//     );
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _focusNode.dispose();
//     _shakeController.dispose();
//     super.dispose();
//   }

//   Future<void> _onSubmit() async {
//     final input = _passwordController.text.trim();
//     final correctPassword = _programPasswords[widget.programTitle];

//     if (input.isEmpty) {
//       _triggerError();
//       return;
//     }

//     setState(() => _isLoading = true);

//     // Slight delay for UX feel
//     await Future.delayed(const Duration(milliseconds: 400));

//     if (input == correctPassword) {
//       setState(() => _isLoading = false);
//       _navigateToProgram();
//     } else {
//       setState(() {
//         _isLoading = false;
//         _hasError = true;
//       });
//       _passwordController.clear();
//       _triggerError();
//     }
//   }

//   void _triggerError() {
//     _shakeController.forward(from: 0);
//   }

//   void _navigateToProgram() {
//     switch (widget.programTitle) {
//       case 'Desa Cantik':
//         context.pushPage(const BotnavDescan());
//       case 'Pembinaan Sektoral':
//         context.pushPage(const PembinaanBotnav());
//     }
//   }

//   IconData get _programIcon {
//     switch (widget.programTitle) {
//       case 'Desa Cantik':
//         return Icons.landscape_outlined;
//       case 'Pembinaan Sektoral':
//         return Icons.business_center_outlined;
//       default:
//         return Icons.lock_outline;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.primary,
//               AppColors.primaryLight,
//               AppColors.background,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               // ── App Bar ──────────────────────────────────────
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 8.0,
//                   vertical: 4.0,
//                 ),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new_rounded),
//                     color: Colors.white,
//                     onPressed: () => Navigator.of(context).pop(),
//                   ),
//                 ),
//               ),

//               // ── Content ──────────────────────────────────────
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 16),
//                       const BPSLogoWidget(),
//                       const SizedBox(height: 32),

//                       // Program icon badge
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.15),
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.4),
//                             width: 2,
//                           ),
//                         ),
//                         child: Icon(
//                           _programIcon,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Title
//                       Text(
//                         widget.programTitle,
//                         style: Theme.of(context).textTheme.headlineMedium
//                             ?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 8),

//                       // Subtitle
//                       Text(
//                         'Program ini memerlukan password khusus.\nMasukkan password untuk melanjutkan.',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Colors.white.withOpacity(0.8),
//                           height: 1.5,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 40),

//                       // ── Password card ──────────────────────────
//                       Container(
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.12),
//                               blurRadius: 24,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(
//                                   Icons.lock_outline_rounded,
//                                   size: 20,
//                                   color: AppColors.primary,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   'Masukkan Password',
//                                   style: Theme.of(context).textTheme.titleMedium
//                                       ?.copyWith(
//                                         color: AppColors.primary,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),

//                             // Password field with shake animation
//                             AnimatedBuilder(
//                               animation: _shakeAnimation,
//                               builder: (context, child) {
//                                 final dx = _hasError
//                                     ? 8 *
//                                           (0.5 -
//                                               (_shakeAnimation.value - 0.5)
//                                                   .abs())
//                                     : 0.0;
//                                 return Transform.translate(
//                                   offset: Offset(dx * 4, 0),
//                                   child: child,
//                                 );
//                               },
//                               child: TextField(
//                                 controller: _passwordController,
//                                 focusNode: _focusNode,
//                                 obscureText: _isObscure,
//                                 onChanged: (_) {
//                                   if (_hasError) {
//                                     setState(() => _hasError = false);
//                                   }
//                                 },
//                                 onSubmitted: (_) => _onSubmit(),
//                                 decoration: InputDecoration(
//                                   hintText: 'Password program',
//                                   errorText: _hasError
//                                       ? 'Password salah. Coba lagi.'
//                                       : null,
//                                   prefixIcon: const Icon(
//                                     Icons.key_rounded,
//                                     color: AppColors.primary,
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _isObscure
//                                           ? Icons.visibility_off_outlined
//                                           : Icons.visibility_outlined,
//                                       color: Colors.grey,
//                                     ),
//                                     onPressed: () => setState(
//                                       () => _isObscure = !_isObscure,
//                                     ),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: BorderSide(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: const BorderSide(
//                                       color: AppColors.primary,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                     ),
//                                   ),
//                                   focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                       width: 2,
//                                     ),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.grey.shade50,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),

//                             // Submit button
//                             SizedBox(
//                               width: double.infinity,
//                               height: 52,
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : _onSubmit,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.primary,
//                                   foregroundColor: Colors.white,
//                                   disabledBackgroundColor: AppColors.primary
//                                       .withOpacity(0.6),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   elevation: 0,
//                                 ),
//                                 child: _isLoading
//                                     ? const SizedBox(
//                                         width: 22,
//                                         height: 22,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2.5,
//                                         ),
//                                       )
//                                     : const Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(Icons.login_rounded, size: 20),
//                                           SizedBox(width: 8),
//                                           Text(
//                                             'Masuk ke Program',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 24),

//                       // Info hint
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.info_outline_rounded,
//                             size: 16,
//                             color: Colors.white.withOpacity(0.7),
//                           ),
//                           const SizedBox(width: 6),
//                           Text(
//                             'Hubungi admin BPS jika lupa password.',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.white.withOpacity(0.7),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 32),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
