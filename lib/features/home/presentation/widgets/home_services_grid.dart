import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  static const _items = [
    _ServiceItem(
      icon: Iconsax.shop,
      line1: 'Merchant',
      line2: 'payment',
    ),
    _ServiceItem(
      icon: Iconsax.receipt_item,
      line1: 'Bill',
      line2: 'payment',
    ),
    _ServiceItem(
      icon: Iconsax.wallet_money,
      line1: 'Credit &',
      line2: 'saving',
    ),
    _ServiceItem(
      icon: Iconsax.money_send,
      line1: 'Transfer',
      line2: 'money',
    ),
    _ServiceItem(
      icon: Iconsax.simcard,
      line1: 'Airtime/',
      line2: 'package',
    ),
    _ServiceItem(
      icon: Iconsax.category_2,
      line1: 'Macro',
      line2: 'services',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        children: [
          for (var row = 0; row < 2; row++) ...[
            if (row > 0) const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                for (var col = 0; col < 3; col++)
                  Expanded(child: _ServiceTile(item: _items[row * 3 + col])),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ServiceItem {
  const _ServiceItem({
    required this.icon,
    required this.line1,
    required this.line2,
  });

  final IconData icon;
  final String line1;
  final String line2;
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.item});

  final _ServiceItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, size: 36, color: AppColors.primary),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${item.line1}\n${item.line2}',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: AppTextStyles.serviceLabel,
          ),
        ],
      ),
    );
  }
}
