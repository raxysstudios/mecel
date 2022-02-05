import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/modules/play/models/input_key.dart';
import 'package:wordle/modules/play/utils.dart';
import 'package:wordle/shared/models/language.dart';
import 'package:wordle/store.dart';

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
  late final word = getRandomWord(widget.language.words);
  late final InputLayout layout = layoutFromStrings(
    strings: widget.language.layout,
    backspace: () {
      final text = attempts.last;
      if (text.isNotEmpty) {
        setState(() {
          attempts.last = text.substring(0, text.length - 1);
        });
      }
    },
    done: () {
      if (attempts.last.length == word.length &&
          attempts.length < widget.maxAttempts) {
        setState(() {
          attempts.add('');
        });
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Wordle',
            style: GoogleFonts.firaMono(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          for (var i = 0; i < widget.maxAttempts; i++)
            WordAttempt(
              length: word.length,
              text: i < attempts.length ? attempts[i] : '',
              check: i < attempts.length - 1 ? word : null,
            ),
          const Expanded(
            child: SizedBox(),
          ),
          KeyboardInput(
            layout: layout,
            textCallback: (c) {
              if (attempts.last.length < word.length) {
                setState(() {
                  attempts.last += c;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
