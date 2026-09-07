import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:safaricom_test/core/locale/app_language.dart';

class LanguageNotifier extends Notifier<AppLanguage> {
  @override
  AppLanguage build() => AppLanguage.english;

  void select(AppLanguage language) => state = language;
}

final languageProvider = NotifierProvider<LanguageNotifier, AppLanguage>(
  LanguageNotifier.new,
);
