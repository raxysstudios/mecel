import 'package:flutter/material.dart';
import 'package:wordle/modules/help/screens/help.dart';
import 'package:wordle/modules/play/models/input_key.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/modules/play/widgets/share_button.dart';
import 'package:wordle/shared/models/game_config.dart';
import 'package:wordle/shared/snackbar.dart';

import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    required this.config,
    required this.maxAttempts,
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

  late final InputLayout layout = layoutFromStrings(
    strings: widget.config.language.layout,
    backspace: backspace,
    done: submit,
  );

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('MECEL'),
        leading: IconButton(
          onPressed: () => Navigator.push<void>(
            context,
            MaterialPageRoute(
              builder: (context) => const HelpScreen(),
            ),
          ),
          tooltip: 'Гъил гун',
          icon: const Icon(Icons.help_outline_rounded),
        ),
        actions: [
          if (done)
            ShareButton(
              maxAttempts: widget.maxAttempts,
              attempts: attempts,
              word: word,
              language: widget.config.language,
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
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
          const Expanded(
            child: SizedBox(),
          ),
          KeyboardInput(
            layout: layout,
            textCallback: input,
          ),
        ],
      ),
    );
  }
}
