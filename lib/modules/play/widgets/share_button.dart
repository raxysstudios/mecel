import 'package:flutter/material.dart';
import 'package:wordle/shared/snackbar.dart';

import '../utils.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.maxAttempts,
    required this.attempts,
    required this.word,
    Key? key,
  }) : super(key: key);

  final int maxAttempts;
  final List<String> attempts;
  final String word;

  String computeResultText() {
    var text = 'Mecel ${getCurrentDay() + 1} ${attempts.length}/$maxAttempts\n';
    for (final attempt in attempts) {
      text += '\n';
      for (var i = 0; i < word.length && i < attempt.length; i++) {
        if (attempt[i] == word[i]) {
          text += '🟩';
        } else if (word.contains(attempt[i])) {
          text += '🟨';
        } else {
          text += '⬜';
        }
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await copyText(context, computeResultText());
        showSnackbar(
          context,
          icon: Icons.content_copy_rounded,
          text: 'Чин къачуна',
        );
      },
      tooltip: 'Паюн',
      icon: const Icon(Icons.share_rounded),
    );
  }
}
