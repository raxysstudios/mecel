import 'package:flutter/material.dart';
import 'package:wordle/modules/help/screens/help.dart';
import 'package:wordle/modules/play/screens/languages.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/modules/play/widgets/share_button.dart';
import 'package:wordle/shared/models/game_config.dart';
import 'package:wordle/shared/models/input_key.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/services/config_loader.dart';
import 'package:wordle/shared/snackbar.dart';
import 'package:wordle/shared/widgets/language_avatar.dart';

import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    required this.config,
    this.maxAttempts = 6,
    Key? key,
  }) : super(key: key);

  final GameConfig config;
  final int maxAttempts;

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late final word = getTodaysWord(widget.config.words);
  var text = '';
  final attempts = <String>[];
  var done = false;

  late final InputLayout layout;

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
    if (done || attempts.length >= widget.maxAttempts) return;
    if (!widget.config.words.contains(text)) {
      showSnackbar(
        context,
        icon: Icons.search_off_rounded,
        text: 'Unknown word',
      );
    }
    setState(() {
      attempts.add(text);
      done = text == word;
      text = '';
    });
    if (done) {
      showSnackbar(
        context,
        icon: Icons.thumb_up_rounded,
        text: 'Лап хъсан я',
      );
    } else if (attempts.length >= widget.maxAttempts) {
      showSnackbar(
        context,
        icon: Icons.lightbulb_rounded,
        text: word.toUpperCase(),
      );
    }
  }

  void backspace() {
    if (done || text.isEmpty) return;
    setState(() {
      text = text.substring(0, text.length - 1);
    });
  }

  void input(String char) {
    if (done || text.length >= word.length) return;
    setState(() {
      text += char;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MECEL'),
        leading: IconButton(
          onPressed: () async {
            final language = await Navigator.push<Language>(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguagesScreen(),
              ),
            );
            if (language != null) {
              startGame(context, await loadConfig(language.name));
            }
          },
          icon: LanguageAvatar(
            widget.config.language,
          ),
        ),
        actions: [
          if (done)
            ShareButton(
              maxAttempts: widget.maxAttempts,
              attempts: attempts,
              word: word,
              language: widget.config.language,
            ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                for (final attempt in attempts)
                  WordAttempt(
                    length: word.length,
                    text: attempt,
                    check: word,
                  ),
                if (!done && attempts.length < widget.maxAttempts)
                  WordAttempt(
                    length: word.length,
                    text: text,
                  ),
                for (var i = attempts.length + (done ? 0 : 1);
                    i < widget.maxAttempts;
                    i++)
                  WordAttempt(length: word.length),
              ],
            ),
          ),
          const Spacer(),
          KeyboardInput(
            layout: layout,
            textCallback: input,
          ),
        ],
      ),
    );
  }
}
