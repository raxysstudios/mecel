import 'package:wordle/shared/models/game_config.dart';

class GameState {
  late GameConfig config;
  int maxAttempts;
  List<String> attempts;
  String word;
  bool done;

  GameState({
    required this.config,
    this.maxAttempts = 6,
    this.attempts = const [],
    this.word = '',
    this.done = false,
  });
}
