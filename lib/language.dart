class Language {
  final int id;

  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "पहाड़ी", "pa"),
      Language(2,  "English", "en"),
      // Language(3, " བོད་སྐད་", "ti"),
      Language(3,  "हिंदी", "hi"),
      // Language(5,  "বাংলা", "be")
    ];
  }
}
