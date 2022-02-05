import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordle/modules/play/models/input_key.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/modules/play/widgets/share_button.dart';
import 'package:wordle/shared/models/language.dart';

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
  final List<String> attempts = [''];
  late final word = getTodaysWord(widget.language.words);
  late final InputLayout layout = layoutFromStrings(
    strings: widget.language.layout,
    backspace: backspace,
    done: nextAttempt,
  );

  bool get done {
    if (attempts.length > 1 && attempts.last.isEmpty) {
      final text = attempts[attempts.length - 2];
      return text == word;
    }
    return false;
  }

  void backspace() {
    final text = attempts.last;
    if (text.isNotEmpty) {
      setState(() {
        attempts.last = text.substring(0, text.length - 1);
      });
    }
  }

  void nextAttempt() {
    if (!done &&
        attempts.last.length == word.length &&
        attempts.length <= widget.maxAttempts) {
      setState(() {
        attempts.add('');
      });
    }
  }

  void inputChar(String char) {
    if (!done && attempts.last.length < word.length) {
      setState(() {
        attempts.last += char;
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
        title: Text(
          'MECEL',
          style: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () => launch('https://t.me/raxysstudios'),
          tooltip: 'Contact',
          icon: const Icon(Icons.send_rounded),
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
          for (var i = 0; i < attempts.length - 1; i++)
            WordAttempt(
              length: word.length,
              text: attempts[i],
              check: word,
            ),
          if (done
              ? attempts.length < widget.maxAttempts
              : attempts.length <= widget.maxAttempts)
            WordAttempt(
              length: word.length,
              text: done ? null : attempts.last,
            ),
          for (var i = attempts.length; i < widget.maxAttempts; i++)
            WordAttempt(length: word.length),
          const Expanded(
            child: SizedBox(),
          ),
          KeyboardInput(
            layout: layout,
            textCallback: inputChar,
          ),
        ],
      ),
    );
  }
}
