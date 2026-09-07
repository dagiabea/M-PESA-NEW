import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/features/auth/presentation/widgets/auth_brand.dart';
import 'package:safaricom_test/features/auth/presentation/widgets/auth_header.dart';
import 'package:safaricom_test/features/auth/presentation/widgets/auth_pin_section.dart';
import 'package:safaricom_test/features/auth/presentation/widgets/auth_welcome.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadii.xxl),
                  bottomRight: Radius.circular(AppRadii.xxl),
                ),
              ),
              child: const SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.sm,
                    AppSpacing.md,
                    AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AuthHeader(),
                      ),
                      
                      Spacer(),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AuthBrand(),
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AuthWelcome(),
                        ),
                      ),

                      SizedBox(height: AppSpacing.md),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: AuthPinSection(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
