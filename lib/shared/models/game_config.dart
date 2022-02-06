import 'package:wordle/shared/models/language.dart';

class GameConfig {
  final Language language;
  final Set<String> words;

  GameConfig({
    required this.language,
    required this.words,
  });
}
