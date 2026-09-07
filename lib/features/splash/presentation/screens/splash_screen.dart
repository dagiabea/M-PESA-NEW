import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';
import 'package:safaricom_test/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Duration displayDuration = Duration(milliseconds: 1800);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(SplashScreen.displayDuration, () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SIGN-IN',
              textAlign: TextAlign.center,
              style: AppTextStyles.splashTitle,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'M-PESA NO.',
              textAlign: TextAlign.center,
              style: AppTextStyles.splash,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'SIGNING IN',
              textAlign: TextAlign.center,
              style: AppTextStyles.splash,
            ),
          ],
        ),
      ),
    );
  }
}
