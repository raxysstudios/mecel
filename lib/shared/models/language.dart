class Language {
  const Language({
    required this.name,
    this.flag,
    required this.layout,
    required this.words,
  });

  final String name;
  final String? flag;
  final List<String> layout;
  final Set<String> words;
}
