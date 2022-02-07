import 'package:flutter/material.dart';
import 'package:wordle/shared/widgets/letter_card.dart';

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
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < length; i++)
            Builder(
              builder: (context) {
                var char = '';
                if (text != null && i < text!.length) char = text![i];
                LetterState? state;

                if (check != null && char.isNotEmpty) {
                  if (char == check![i]) {
                    state = LetterState.present;
                  } else if (check!.contains(char)) {
                    state = LetterState.shifted;
                  } else {
                    state = LetterState.missing;
                  }
                }
                return LetterCard(
                  text: text == null ? null : char,
                  state: state,
                );
              },
            )
        ],
      ),
    );
  }
}
