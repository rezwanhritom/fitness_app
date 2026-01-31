import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/theme/typography.dart';
import '../navigation/app_router.dart';

/// Splash screen with logo placeholder
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1250), // 1.25 seconds total
      vsync: this,
    );

    // Fade in (0-0.4s), hold (0.4-0.6s), fade out (0.6-1.0s)
    _fadeAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 0.4,
      ),
    ]).animate(_controller);

    _controller.forward();

    // Navigate to motivation screen after fade-out
    Future.delayed(const Duration(milliseconds: 1250), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.motivation);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo placeholder - using a container with app name for now
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'FIT',
                    style: AppTypography.numberLarge.copyWith(
                      color: AppColors.onPrimary,
                      fontSize: 48,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // App name
              Text(
                'Fitness App',
                style: AppTypography.heading2.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
