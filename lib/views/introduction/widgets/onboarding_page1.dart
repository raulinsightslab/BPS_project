import 'package:bps_e_learning/core/widgets/custom_button.dart';
import 'package:bps_e_learning/core/widgets/glass_animate.dart';
import 'package:bps_e_learning/core/widgets/logo_widget.dart';
import 'package:bps_e_learning/views/introduction/widgets/onboarding_page2.dart';
import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              imagePath: 'assets/images/illustration1.png',
            ),
          ),
          SizedBox(height: 40),

          // Headline
          Text(
            'Selamat Datang di StaT-Gem',
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),

          // Subheadline
          Text(
            'Platform pembelajaran resmi dari BPS Kabupaten Tangerang.',
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
                      OnboardingPage2(),
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

          // Footer
          Text(
            '© 2025 Badan Pusat Statistik Kabupaten Tangerang',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
