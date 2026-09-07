import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';
import 'package:safaricom_test/features/auth/presentation/widgets/auth_welcome.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            AuthWelcome.avatarUrl,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const ColoredBox(
              color: AppColors.border,
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(Icons.person, color: AppColors.textSecondary),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const Expanded(
          child: Text('Hello Zemdkun 👋', style: AppTextStyles.homeGreeting),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.textPrimary,
            size: 26,
          ),
        ),
      ],
    );
  }
}
