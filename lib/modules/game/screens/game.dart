import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/models/game_config.dart';
import 'package:wordle/models/game_state.dart';
import 'package:wordle/models/input_key.dart';
import 'package:wordle/modules/game/screens/help.dart';
import 'package:wordle/modules/game/services/progress_serivice.dart';
import 'package:wordle/modules/game/utils.dart';
import 'package:wordle/modules/game/widgets/share_button.dart';
import 'package:wordle/modules/language/services/language_service.dart';
import 'package:wordle/modules/settings/screens/settings.dart';
import 'package:wordle/shared/extensions.dart';
import 'package:wordle/shared/snackbar.dart';
import 'package:wordle/shared/widgets/language_avatar.dart';

import '../services/config_service.dart';
import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class GameScreen extends StatefulWidget {
  const GameScreen(
    this.config, {
    Key? key,
  }) : super(key: key);

  final GameConfig config;

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  GameConfig get config => widget.config;

  late final word = getTodaysWord(config.words);
  var text = '';
  var attempts = <String>[];

  bool get done => attempts.isNotEmpty && attempts.last == word;
  bool get ended => done || attempts.length >= config.maxAttempts;

  late final InputLayout layout;

  GameState get game => GameState(
        config: config,
        attempts: attempts,
        maxAttempts: config.maxAttempts,
        word: word,
        done: done,
      );

  @override
  void initState() {
    super.initState();

    restoreProgress(
      config.language.name,
      getCurrentDay(),
    ).then(
      (p) {
        if (p == null) {
          saveProgress(
            config.language.name,
            [],
            getCurrentDay(),
          );
        } else {
          setState(() {
            attempts = p;
          });
        }
      },
    );

    layout = config.layout;
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
    if (!config.words.contains(text)) {
      return showSnackbar(
        context,
        Icons.search_off_rounded,
        context.lclz('unknown'),
      );
    }
    setState(() {
      attempts.add(text);
      text = '';
    });
    saveProgress(config.language.name, attempts);
    if (done) {
      showSnackbar(context, Icons.thumb_up_rounded, context.lclz('good'));
    } else if (ended) {
      showSnackbar(context, Icons.lightbulb_rounded, word.toUpperCase());
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

  void openScreen(Widget Function(BuildContext context) builder) {
    final lcl = context.read<Map<String, String>>();
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: lcl,
          builder: (context, _) => builder(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mecel'),
        leading: IconButton(
          onPressed: () async {
            final language = await changeLanguage(context);
            if (language != null) {
              final config = await loadConfig(language);
              startGame(context, config);
            }
          },
          icon: LanguageAvatar(config.language),
        ),
        actions: [
          IconButton(
            onPressed: () => openScreen(
              (context) => const HelpScreen(),
            ),
            icon: const Icon(Icons.help_rounded),
          ),
          IconButton(
            onPressed: () => openScreen(
              (context) => SettingsScreen(game),
            ),
            icon: const Icon(Icons.settings_rounded),
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
                i < config.maxAttempts;
                i++)
              WordAttempt(length: word.length),
          ],
        ),
      ),
    );
  }
}
