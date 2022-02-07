import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:wordle/modules/game/screens/game.dart';
import 'package:wordle/modules/language/services/assets_service.dart';
import 'package:wordle/shared/models/game_config.dart';
import 'package:wordle/shared/models/input_key.dart';
import 'package:wordle/shared/utils.dart';

const _localization = {
  'howTo': 'How to play?',
  'guesses': 'Guess а word in 6 tries.',
  'letters':
      'Each guess must be a valid 5 letter word. Hit the enter button to submit.',
  'colors':
      'After each guess, the color of the tiles will change to show how close your guess was to the word.',
  'examples': 'Examples',
  'e1Word': 'weary',
  'e1Caption': 'The letter W is in the word and in the correct spot.',
  'e2Word': 'house',
  'e2Caption': 'The letter U is in the word but in the wrong spot.',
  'e3Word': 'vague',
  'e3Caption': 'The letter E is not in the word in any spot.',
  'daily': 'A new word will be available each day!',
  'play': 'Play',
  'share': 'Share',
  'contact': 'Contact',
  'settings': 'Settings',
  'unknown': 'Unknown word',
  'coming': 'The next word opens soon.',
  'copied': 'Copied',
  'good': 'Good job!'
};

Future<GameConfig> loadConfig(String? languageName) async {
  final language = await findLanguage(languageName);
  final data = await rootBundle
      .loadString('assets/languages/${language.name}.json')
      .then((r) => json.decode(r) as Map<String, dynamic>);

  final words = json2list(data['words'])!.toSet();
  final layout = json2list(data['layout'])!
      .map((s) => s.characters.map((c) => InputKey(c)))
      .map((r) => r.toList())
      .toList();
  final localization = data['localization'] == null
      ? _localization
      : Map.castFrom<String, dynamic, String, String>(
          data['localization'] as Map<String, dynamic>,
        );

  return GameConfig(
    language: language,
    words: words,
    layout: layout,
    localization: localization,
  );
}

void startGame(BuildContext context, GameConfig config) {
  Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute(
      builder: (context) => Provider.value(
        value: config.localization,
        builder: (context, _) => GameScreen(config: config),
      ),
    ),
  );
}
