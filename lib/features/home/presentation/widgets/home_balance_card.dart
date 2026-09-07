import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';
import 'package:safaricom_test/core/utils/money_formatter.dart';
import 'package:safaricom_test/features/auth/presentation/providers/auth_provider.dart';

class HomeBalanceCard extends ConsumerStatefulWidget {
  const HomeBalanceCard({super.key});

  @override
  ConsumerState<HomeBalanceCard> createState() => _HomeBalanceCardState();
}

class _HomeBalanceCardState extends ConsumerState<HomeBalanceCard> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).session?.user;
    final currency = user?.currency ?? 'ETB';
    final balance = MoneyFormatter.format(user?.balance ?? 0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.xl),
      child: Container(
        width: double.infinity,
        height: 228,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF3A40),
              AppColors.primary,
              Color(0xFFD41018),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              right: -40,
              top: -52,
              child: _GlowCircle(size: 168, opacity: 0.18),
            ),
            Positioned(
              right: 22,
              top: 92,
              child: Transform.rotate(
                angle: -0.4,
                child: Container(
                  width: 46,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.28),
                        Colors.white.withValues(alpha: 0.08),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
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
                            Text(
                              'Main Balance ($currency)',
                              style: AppTextStyles.balanceLabel,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              _visible ? balance : '********',
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
                        child: const Text(
                          '+ Add Money',
                          style: AppTextStyles.addMoney,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _SecondaryBalance(
                        label: 'Reward Balance',
                        amount: _visible ? '0.00' : '****',
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _SecondaryBalance(
                        label: 'Errif Balance',
                        amount: _visible ? '0.00' : '****',
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
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
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
