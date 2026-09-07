import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_balance_card.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_header.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_scan_fab.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_services_grid.dart';
import 'package:safaricom_test/features/home/presentation/widgets/home_transactions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background,
        floatingActionButton: const HomeScanFab(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              88,
            ),
            children: const [
              HomeHeader(),
              SizedBox(height: AppSpacing.md),
              HomeBalanceCard(),
              SizedBox(height: AppSpacing.md),
              HomeServicesGrid(),
              SizedBox(height: AppSpacing.md),
              HomeTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}
