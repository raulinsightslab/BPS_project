import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/core/utils/app_images.dart';
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/glass_animate.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  final VoidCallback? onNext;

  const OnboardingPage1({super.key, this.onNext});

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
              'Selamat Datang di StaT-Gem',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Subheadline
            Text(
              'Platform pembelajaran resmi dari BPS Kabupaten Tangerang.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Continue Button
            OnboardingButton(text: 'Lanjut', onPressed: onNext),
            const SizedBox(height: 24),

            // Page Indicator
            const PageIndicator(
              currentPage: 0,
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
