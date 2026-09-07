import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safaricom_test/core/constants/app_colors.dart';
import 'package:safaricom_test/core/constants/app_radii.dart';
import 'package:safaricom_test/core/constants/app_spacing.dart';
import 'package:safaricom_test/core/constants/app_text_styles.dart';
import 'package:safaricom_test/core/locale/app_language.dart';
import 'package:safaricom_test/core/locale/language_provider.dart';

class LanguageSelector extends ConsumerStatefulWidget {
  const LanguageSelector({super.key});

  @override
  ConsumerState<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends ConsumerState<LanguageSelector> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeMenu();
    super.dispose();
  }

  void _removeMenu() {
    _entry?.remove();
    _entry = null;
    if (_isOpen) {
      _isOpen = false;
    }
  }

  void _toggleMenu() {
    if (_isOpen) {
      setState(_removeMenu);
      return;
    }

    _entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => setState(_removeMenu),
              ),
            ),
            CompositedTransformFollower(
              link: _link,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: _LanguageMenu(
                selected: ref.read(languageProvider),
                onSelect: (language) {
                  ref.read(languageProvider.notifier).select(language);
                  setState(_removeMenu);
                },
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_entry!);
    setState(() => _isOpen = true);
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);

    return CompositedTransformTarget(
      link: _link,
      child: GestureDetector(
        onTap: _toggleMenu,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language_rounded,
              color: AppColors.onPrimary,
              size: 22,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              language.label,
              style: AppTextStyles.balanceLabel.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              _isOpen
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.onPrimary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageMenu extends StatelessWidget {
  const _LanguageMenu({required this.selected, required this.onSelect});

  final AppLanguage selected;
  final ValueChanged<AppLanguage> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 188,
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final language in AppLanguage.values)
              _LanguageOption(
                language: language,
                selected: language == selected,
                onTap: () => onSelect(language),
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language.label,
                style: AppTextStyles.body.copyWith(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_rounded,
                size: 18,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}
