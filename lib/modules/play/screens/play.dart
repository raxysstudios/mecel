import 'package:flutter/material.dart';
import 'package:wordle/modules/help/screens/help.dart';
import 'package:wordle/modules/play/models/input_key.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/modules/play/widgets/share_button.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/shared/snackbar.dart';

import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    required this.language,
    required this.maxAttempts,
    Key? key,
  }) : super(key: key);

  final Language language;
  final int maxAttempts;

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late final word = getTodaysWord(widget.language.words);
  var text = '';
  final attempts = <String>[];
  var done = false;

  late final InputLayout layout = layoutFromStrings(
    strings: widget.language.layout,
    backspace: backspace,
    done: submit,
  );

  void backspace() {
    if (text.isNotEmpty) {
      setState(() {
        text = text.substring(0, text.length - 1);
      });
    }
  }

  void submit() {
    if (!done &&
        text.length == word.length &&
        attempts.length < widget.maxAttempts) {
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
  }

  void input(String char) {
    if (!done && text.length < word.length) {
      setState(() {
        text += char;
      });
    }
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
