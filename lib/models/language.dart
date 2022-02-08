class Language {
  final String name;
  final String nativeName;
  final String flag;

  const Language({
    required this.name,
    required this.nativeName,
    required this.flag,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json['name'] as String,
      nativeName: json['nativeName'] as String,
      flag: json['flag'] as String,
    );
  }
}
