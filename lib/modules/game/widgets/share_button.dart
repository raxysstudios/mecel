import 'package:flutter/material.dart';
import 'package:wordle/models/game_state.dart';
import 'package:wordle/modules/game/utils.dart';
import 'package:wordle/shared/extensions.dart';
import 'package:wordle/shared/snackbar.dart';

class ShareButton extends StatelessWidget {
  const ShareButton(
    this.game, {
    Key? key,
  }) : super(key: key);

  final GameState game;

  String getSharingText() {
    var text = 'mecel • '
        '${game.config.language.name}'
        ' • ${getCurrentDay()} '
        '${game.attempts.length}/${game.maxAttempts}\n';

    text = text.titleCase;

    final word = game.word;
    for (final attempt in game.attempts) {
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

  Future<void> share(BuildContext context) async {
    final text = getSharingText();
    await copyText(context, text);
    showSnackbar(context, Icons.content_copy_rounded, context.lclz('copied'));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => share(context),
      label: Text(context.lclz('share')),
      icon: const Icon(Icons.share_rounded),
    );
  }
}
