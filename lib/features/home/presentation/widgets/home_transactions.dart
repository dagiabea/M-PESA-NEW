import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';

class HomeTransactions extends StatelessWidget {
  const HomeTransactions({super.key});

  static const _items = [
    _TransactionItem(
      name: 'Aster Mequanent',
      type: 'Bank',
      amount: '+220',
      time: 'Today',
      isCredit: true,
      kind: _TransactionKind.cbe,
    ),
    _TransactionItem(
      name: 'Dawit Tesfaye',
      type: 'Bank',
      amount: '-1,500',
      time: 'Yesterday',
      isCredit: false,
      kind: _TransactionKind.cbe,
    ),
    _TransactionItem(
      name: 'Airtime Purchase',
      type: 'M-PESA',
      amount: '-50',
      time: 'Today',
      isCredit: false,
      kind: _TransactionKind.airtime,
    ),
    _TransactionItem(
      name: 'Hanna Bekele',
      type: 'Bank',
      amount: '+3,200',
      time: '6 Sep',
      isCredit: true,
      kind: _TransactionKind.cbe,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.xl),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Text('Transactions', style: AppTextStyles.sectionTitle),
              ),
              Text('See all', style: AppTextStyles.seeAll),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < _items.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            _TransactionTile(item: _items[i]),
          ],
        ],
      ),
    );
  }
}

enum _TransactionKind { cbe, airtime }

class _TransactionItem {
  const _TransactionItem({
    required this.name,
    required this.type,
    required this.amount,
    required this.time,
    required this.isCredit,
    required this.kind,
  });

  final String name;
  final String type;
  final String amount;
  final String time;
  final bool isCredit;
  final _TransactionKind kind;
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.item});

  final _TransactionItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LeadingIcon(kind: item.kind),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: AppTextStyles.transactionTitle),
              Text(item.type, style: AppTextStyles.transactionSubtitle),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              item.amount,
              style: item.isCredit
                  ? AppTextStyles.transactionCredit
                  : AppTextStyles.transactionDebit,
            ),
            Text(item.time, style: AppTextStyles.transactionSubtitle),
          ],
        ),
      ],
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.kind});

  final _TransactionKind kind;

  @override
  Widget build(BuildContext context) {
    if (kind == _TransactionKind.cbe) {
      return Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/cbe_logo.png',
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const ColoredBox(
            color: Color(0xFF5D2E8C),
            child: Center(
              child: Text(
                'CBE',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF5C518),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/mpesa_mobile_icon.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
