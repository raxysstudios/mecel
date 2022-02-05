import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/modules/play/widgets/letter_card.dart';

class WordAttempt extends StatelessWidget {
  const WordAttempt({
    required this.length,
    this.text,
    this.check,
    Key? key,
  }) : super(key: key);

  final int length;
  final String? text;
  final String? check;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < length; i++)
            Builder(
              builder: (context) {
                var char = '';
                if (text != null && i < text!.length) char = text![i];
                Color? color;

                if (check != null && char.isNotEmpty) {
                  final j = check!.indexOf(char);
                  color = j == -1
                      ? Colors.blueGrey.shade400
                      : j == i
                          ? Colors.green.shade400
                          : Colors.amber.shade400;
                }
                return LetterCard(
                  text: text == null ? null : char,
                  backgroundColor: color ?? colorScheme.surface,
                  color: color == null ? null : colorScheme.surface,
                );
              },
            )
        ],
      ),
    );
  }
}
