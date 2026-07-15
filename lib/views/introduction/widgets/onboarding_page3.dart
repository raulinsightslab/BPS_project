import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/core/utils/app_images.dart';
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/glass_animate.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:bps_e_learning/views/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            // BPS Logo
            BPSLogoWidget(),
            const SizedBox(height: 40),
            // Illustration with Glass Effect
            Expanded(
              child: GlassIllustrationBox(imagePath: AppImages.onboarding1),
            ),
            const SizedBox(height: 40),
            // Headline
            Text(
              'Pilih Program Pembelajaran Anda',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subheadline
            Text(
              'Pilih program yang sesuai dengan kebutuhan pembelajaran Anda',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Continue to Login
            OnboardingButton(
              text: 'Masuk',
              onPressed: () async {
                // Tandai onboarding sudah selesai
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('hasSeenOnboarding', true);

                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          final tween = Tween(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeInOut));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Page Indicator
            const PageIndicator(
              currentPage: 2,
              totalPages: 3,
              activeColor: Color(0xFFFFA726),
              inactiveColor: Color(0xFFFFE0B2),
            ),
          ],
        ),
      ),
    );
  }
}
