import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
