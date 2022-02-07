import 'package:wordle/shared/models/input_key.dart';
import 'package:wordle/shared/models/language.dart';

class GameConfig {
  final Language language;
  final InputLayout layout;
  final Set<String> words;
  final Map<String, String> localization;

  GameConfig({
    required this.language,
    required this.layout,
    required this.words,
    required this.localization,
  });
}
