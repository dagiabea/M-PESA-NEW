import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';

class HomeScanFab extends StatefulWidget {
  const HomeScanFab({super.key});

  @override
  State<HomeScanFab> createState() => _HomeScanFabState();
}

class _HomeScanFabState extends State<HomeScanFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _Wave(progress: _controller.value),
              _Wave(progress: (_controller.value + 0.5) % 1),
              child!,
            ],
          );
        },
        child: Material(
          color: AppColors.primary,
          elevation: 4,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                Iconsax.scan,
                color: AppColors.onPrimary,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  const _Wave({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final size = 56 + (progress * 32);
    return Opacity(
      opacity: (1 - progress) * 0.5,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}
