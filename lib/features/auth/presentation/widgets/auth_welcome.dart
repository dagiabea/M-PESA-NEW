import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';

class AuthWelcome extends StatelessWidget {
  const AuthWelcome({super.key});

  static const String avatarUrl =
      'https://randomuser.me/api/portraits/men/32.jpg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipOval(
            child: Image.network(
              avatarUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const ColoredBox(
                color: Color(0x33FFFFFF),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.person,
                    color: AppColors.onPrimary,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('welcome back', style: AppTextStyles.welcomeBack),
              Text('Zemdkun Kidane', style: AppTextStyles.welcomeName),
              Text('+251707949336', style: AppTextStyles.welcomePhone),
            ],
          ),
        ],
      ),
    );
  }
}
