import 'package:flutter/material.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';
import 'package:safaricom_test/core/widgets/primary_button.dart';
import 'package:safaricom_test/routes/app_routes.dart';

class AuthPinSection extends StatefulWidget {
  const AuthPinSection({super.key});

  @override
  State<AuthPinSection> createState() => _AuthPinSectionState();
}

class _AuthPinSectionState extends State<AuthPinSection> {
  static const int _length = 4;
  String _pin = '';

  void _onDigit(String digit) {
    if (_pin.length >= _length) return;
    setState(() => _pin += digit);
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline_rounded, color: AppColors.secondary, size: 22),
            SizedBox(width: AppSpacing.sm),
            Text('Enter Your M-PESA PIN', style: AppTextStyles.pinTitle),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            for (var i = 0; i < _length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _PinBox(
                  filled: i < _pin.length,
                  isActive: i == _pin.length,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.xl),
            ),
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.xs,
              horizontal: AppSpacing.xs,
            ),
            child: _PinKeypad(
              onDigit: _onDigit,
              onBackspace: _onBackspace,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PrimaryButton(
          label: 'Continue',
          onPressed: _pin.length == _length
              ? () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.home,
                  )
              : null,
        ),
        const SizedBox(height: AppSpacing.md),
        const _AuthFooter(),
      ],
    );
  }
}

class _PinBox extends StatelessWidget {
  const _PinBox({required this.filled, required this.isActive});

  final bool filled;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      // width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.border,
          width: isActive ? 2 : 1,
        ),
      ),
      child: filled
          ? Text('•', style: AppTextStyles.heading1.copyWith(height: 1))
          : isActive
              ? const _PinCursor()
              : null,
    );
  }
}

class _PinCursor extends StatefulWidget {
  const _PinCursor();

  @override
  State<_PinCursor> createState() => _PinCursorState();
}

class _PinCursorState extends State<_PinCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 22,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

class _PinKeypad extends StatelessWidget {
  const _PinKeypad({required this.onDigit, required this.onBackspace});

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  static const List<List<String>> _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', 'back'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in _rows)
          Expanded(
            child: Row(
              children: [
                for (final key in row)
                  Expanded(
                    child: key.isEmpty
                        ? const SizedBox.shrink()
                        : key == 'back'
                        ? _KeypadButton(
                            onTap: onBackspace,
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: AppColors.textPrimary,
                              size: 22,
                            ),
                          )
                        : _KeypadButton(
                            onTap: () => onDigit(key),
                            child: Text(key, style: AppTextStyles.keypadDigit),
                          ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _KeypadButton extends StatelessWidget {
  const _KeypadButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Center(child: child),
      ),
    );
  }
}

class _AuthFooter extends StatelessWidget {
  const _AuthFooter();

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('forgot PIN?', style: AppTextStyles.authFooterPrimary),
          SizedBox(width: AppSpacing.lg),
          _FooterLink(
            icon: Icons.headset_mic_outlined,
            label: 'contact us',
          ),
          SizedBox(width: AppSpacing.lg),
          _FooterLink(
            icon: Icons.description_outlined,
            label: 'terms and conditions',
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.textPrimary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          maxLines: 1,
          softWrap: false,
          style: AppTextStyles.authFooter,
        ),
      ],
    );
  }
}
