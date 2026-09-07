import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';

class HomeBalanceCard extends StatefulWidget {
  const HomeBalanceCard({super.key});

  @override
  State<HomeBalanceCard> createState() => _HomeBalanceCardState();
}

class _HomeBalanceCardState extends State<HomeBalanceCard> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 196,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Main Balance (Birr)',
                      style: AppTextStyles.balanceLabel,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _visible ? '2,000,000' : '********',
                      style: AppTextStyles.balanceAmount,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppRadii.lg),
                ),
                child: const Text('+ Add Money', style: AppTextStyles.addMoney),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _SecondaryBalance(
                label: 'Reward Balance',
                amount: _visible ? '50.00' : '****',
              ),
              const SizedBox(width: AppSpacing.xl),
              _SecondaryBalance(
                label: 'Errif Balance',
                amount: _visible ? '1500.00' : '****',
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => setState(() => _visible = !_visible),
                child: Icon(
                  _visible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SecondaryBalance extends StatelessWidget {
  const _SecondaryBalance({
    required this.label,
    required this.amount,
  });

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.secondaryBalanceLabel),
        const SizedBox(height: 2),
        Text(amount, style: AppTextStyles.secondaryBalanceAmount),
      ],
    );
  }
}
