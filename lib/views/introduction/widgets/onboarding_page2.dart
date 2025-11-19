import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/glass_animate.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/core/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'onboarding_page3.dart';

class OnboardingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA726), Color(0xFFFFE0B2), Color(0xFFFFFFFF)],
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
                child: GlassIllustrationBox(
                  imagePath: 'assets/images/illustration2.png',
                ),
              ),
              SizedBox(height: 40),

              // Headline
              Text(
                'Belajar Statistik Lebih Mudah dan Fleksibel',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Subheadline
              Text(
                'Akses materi dan pembelajaran interaktif di mana pun dan kapan pun.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              // Continue Button
              OnboardingButton(
                text: 'Lanjut',
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OnboardingPage3(),
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
                currentPage: 1,
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
