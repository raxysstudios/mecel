import 'package:wordle/models/game_config.dart';

class GameState {
  late GameConfig config;
  int maxAttempts;
  List<String> attempts;
  String word;
  bool done;

  String lclz(String key) => config.localization[key] ?? 'error';

  GameState({
    required this.config,
    this.maxAttempts = 6,
    this.attempts = const [],
    this.word = '',
    this.done = false,
  });
}
