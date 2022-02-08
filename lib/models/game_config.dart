import 'package:wordle/models/input_key.dart';
import 'package:wordle/models/language.dart';

class GameConfig {
  final Language language;
  final InputLayout layout;
  final Set<String> words;
  final Map<String, String> localization;
  final int maxAttempts;

  GameConfig({
    required this.language,
    required this.layout,
    required this.words,
    required this.localization,
    this.maxAttempts = 6,
  });
}
