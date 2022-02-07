import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordle/modules/game/screens/help.dart';
import 'package:wordle/modules/game/screens/languages.dart';
import 'package:wordle/modules/game/utils.dart';
import 'package:wordle/modules/game/widgets/share_button.dart';
import 'package:wordle/shared/models/game_config.dart';
import 'package:wordle/shared/models/game_state.dart';
import 'package:wordle/shared/models/input_key.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/services/config_loader.dart';
import 'package:wordle/shared/snackbar.dart';
import 'package:wordle/shared/widgets/language_avatar.dart';

import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({
    required this.config,
    this.maxAttempts = 6,
    Key? key,
  }) : super(key: key);

  final GameConfig config;
  final int maxAttempts;

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  late final word = getTodaysWord(widget.config.words);
  var text = '';
  final attempts = <String>[];
  bool get done => attempts.isNotEmpty && attempts.last == word;
  bool get ended => done || attempts.length >= widget.maxAttempts;

  late final InputLayout layout;

  GameState get game => GameState(
        config: widget.config,
        attempts: attempts,
        maxAttempts: widget.maxAttempts,
        word: word,
        done: done,
      );

  @override
  void initState() {
    super.initState();

    layout = widget.config.layout;
    layout.last = [
      InputKey(
        null,
        flex: 2,
        icon: Icons.done_rounded,
        callback: submit,
      ),
      ...layout.last,
      InputKey(
        null,
        flex: 2,
        icon: Icons.backspace_rounded,
        callback: backspace,
      ),
    ];
  }

  void submit() {
    if (text.length < word.length || ended) return;
    // if (!widget.config.words.contains(text)) {
    //   return showSnackbar(
    //     context,
    //     icon: Icons.search_off_rounded,
    //     text: 'Unknown word',
    //   );
    // }
    setState(() {
      attempts.add(text);
      text = '';
    });
    if (done) {
      showSnackbar(
        context,
        icon: Icons.thumb_up_rounded,
        text: 'Лап хъсан я',
      );
    } else if (ended) {
      showSnackbar(
        context,
        icon: Icons.lightbulb_rounded,
        text: word.toUpperCase(),
      );
    }
  }

  void backspace() {
    if (ended || text.isEmpty) return;
    setState(() {
      text = text.substring(0, text.length - 1);
    });
  }

  void input(String char) {
    if (ended || text.length >= word.length) return;
    setState(() {
      text += char;
    });
  }

  void changeLanguage() async {
    final language = await Navigator.push<Language>(
      context,
      MaterialPageRoute(
        builder: (context) => const LanguagesScreen(),
      ),
    );
    if (language != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', language.name);
      startGame(context, await loadConfig(language.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mecel'),
        leading: IconButton(
          onPressed: changeLanguage,
          icon: LanguageAvatar(widget.config.language),
        ),
        actions: [
          // IconButton(
          //   onPressed: () => Navigator.push<Language>(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => StatsScreen(game),
          //     ),
          //   ),
          //   tooltip: 'Statistics',
          //   icon: const Icon(
          //     Icons.leaderboard_rounded,
          //   ),
          // ),
          IconButton(
            onPressed: () => Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => const HelpScreen(),
              ),
            ),
            tooltip: 'Гъил гун',
            icon: const Icon(Icons.help_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      floatingActionButton: done ? ShareButton(game) : null,
      bottomSheet: ended
          ? null
          : SizedBox(
              height: 8 + 48.0 * layout.length,
              child: KeyboardInput(
                layout: layout,
                textCallback: input,
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            for (final attempt in attempts)
              WordAttempt(
                length: word.length,
                text: attempt,
                check: word,
              ),
            if (!ended)
              WordAttempt(
                length: word.length,
                text: text,
              ),
            for (var i = attempts.length + (ended ? 0 : 1);
                i < widget.maxAttempts;
                i++)
              WordAttempt(length: word.length),
          ],
        ),
      ),
    );
  }
}
