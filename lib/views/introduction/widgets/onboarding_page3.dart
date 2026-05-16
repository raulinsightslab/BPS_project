import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:bps_e_learning/core/utils/app_images.dart';
import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/glass_animate.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:bps_e_learning/views/login.dart';
import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
              SizedBox(height: 60),
              // BPS Logo
              BPSLogoWidget(),
              SizedBox(height: 40),
              // Illustration with Glass Effect
              Expanded(
                child: GlassIllustrationBox(imagePath: AppImages.onboarding1),
              ),
              SizedBox(height: 40),
              // Headline
              Text(
                'Pilih Program Pembelajaran Anda',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              // Subheadline
              Text(
                'Pilih program yang sesuai dengan kebutuhan pembelajaran Anda',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              // Continue to Program Selection
              OnboardingButton(
                text: 'Masuk',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.easeInOut;
                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
              ),
              SizedBox(height: 24),

              // Page Indicator
              PageIndicator(
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
