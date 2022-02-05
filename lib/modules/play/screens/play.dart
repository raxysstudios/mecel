import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/modules/play/models/input_key.dart';
import 'package:wordle/modules/play/utils.dart';

import '../widgets/keyboard_input.dart';
import '../widgets/word_attempt.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    required this.layoutStrings,
    required this.word,
    required this.maxAttempts,
    Key? key,
  }) : super(key: key);

  final List<String> layoutStrings;
  final String word;
  final int maxAttempts;

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final List<String> attempts = [''];
  late final InputLayout layout = layoutFromStrings(
    strings: widget.layoutStrings,
    backspace: () {
      final text = attempts.last;
      if (text.isNotEmpty) {
        setState(() {
          attempts.last = text.substring(0, text.length - 1);
        });
      }
    },
    done: () {
      if (attempts.last.length == widget.word.length &&
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
              length: widget.word.length,
              text: i < attempts.length ? attempts[i] : '',
              check: i < attempts.length - 1 ? widget.word : null,
            ),
          const Expanded(
            child: SizedBox(),
          ),
          KeyboardInput(
            layout: layout,
            textCallback: (c) {
              if (attempts.last.length < widget.word.length) {
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
