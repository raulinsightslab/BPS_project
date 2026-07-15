import 'package:bps_e_learning/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/onboarding_page1.dart';
import '../widgets/onboarding_page2.dart';
import '../widgets/onboarding_page3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
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
          ),

          // PageView — pages dibuat lazy via builder agar tidak semua
          // di-instantiate sekaligus saat pertama kali load
          PageView.builder(
            controller: _pageController,
            physics: const ClampingScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return OnboardingPage1(onNext: _goToNextPage);
                case 1:
                  return OnboardingPage2(onNext: _goToNextPage);
                case 2:
                  return OnboardingPage3();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
