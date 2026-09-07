enum AppLanguage {
  english,
  amharic;

  String get label => switch (this) {
    AppLanguage.english => 'English',
    AppLanguage.amharic => 'Amharic',
  };
}
